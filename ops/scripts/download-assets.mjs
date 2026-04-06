/**
 * Parses design source and downloads remote image URLs into the web handoff tree.
 * Run from repo root: node ops/scripts/download-assets.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import https from "https";
import http from "http";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..", "..");
const penPath = path.join(root, "artifacts", "design", "0027.pen");
const outDir = path.join(root, "artifacts", "web-handoff", "web", "assets", "images");

const pen = JSON.parse(fs.readFileSync(penPath, "utf8"));

const urls = new Set();

function walk(node) {
  if (!node || typeof node !== "object") return;
  const fill = node.fill;
  if (fill && fill.type === "image" && fill.url && /^https?:\/\//i.test(fill.url)) {
    urls.add(fill.url);
  }
  if (Array.isArray(node.children)) node.children.forEach(walk);
}

walk(pen);

fs.mkdirSync(outDir, { recursive: true });

const manifest = {};

function download(url, dest) {
  return new Promise((resolve, reject) => {
    const lib = url.startsWith("https") ? https : http;
    const file = fs.createWriteStream(dest);
    lib
      .get(url, (res) => {
        if (res.statusCode === 301 || res.statusCode === 302) {
          file.close();
          fs.unlinkSync(dest);
          return download(res.headers.location, dest).then(resolve).catch(reject);
        }
        if (res.statusCode !== 200) {
          file.close();
          fs.unlinkSync(dest);
          return reject(new Error(`HTTP ${res.statusCode} for ${url}`));
        }
        res.pipe(file);
        file.on("finish", () => {
          file.close();
          resolve();
        });
      })
      .on("error", (err) => {
        file.close();
        fs.unlink(dest, () => {});
        reject(err);
      });
  });
}

let i = 0;
for (const url of urls) {
  i += 1;
  const u = new URL(url);
  const base = path.basename(u.pathname) || "image";
  const ext = path.extname(base).match(/\.(jpe?g|png|webp|gif)$/i) ? path.extname(base) : ".jpg";
  const name = `unsplash-${String(i).padStart(2, "0")}${ext}`;
  const dest = path.join(outDir, name);
  process.stdout.write(`Downloading ${name}...\n`);
  try {
    await download(url, dest);
    manifest[url] = `assets/images/${name}`;
  } catch (e) {
    process.stderr.write(`Failed: ${url} — ${e.message}\n`);
  }
}

fs.writeFileSync(
  path.join(root, "artifacts", "web-handoff", "web", "assets", "manifest.json"),
  JSON.stringify(manifest, null, 2),
);
process.stdout.write(`Done. ${Object.keys(manifest).length} files.\n`);
