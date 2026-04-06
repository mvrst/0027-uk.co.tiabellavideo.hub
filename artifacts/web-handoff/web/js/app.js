(function () {
  const screens = document.querySelectorAll(".screen");
  const railBtns = document.querySelectorAll("[data-goto]");

  function show(id) {
    screens.forEach((s) => {
      s.classList.toggle("is-visible", s.id === id);
    });
    railBtns.forEach((b) => {
      b.classList.toggle("is-active", b.getAttribute("data-goto") === id);
    });
    const phone = document.querySelector(".phone");
    if (phone) {
      phone.scrollTop = 0;
    }
    const active = document.getElementById(id);
    if (active) {
      const body = active.querySelector(".screen-body");
      if (body) body.scrollTop = 0;
    }
    if (window.lucide && typeof window.lucide.createIcons === "function") {
      window.lucide.createIcons();
    }
  }

  railBtns.forEach((btn) => {
    btn.addEventListener("click", () => show(btn.getAttribute("data-goto")));
  });

  const initial = new URLSearchParams(window.location.search).get("screen") || "s01";
  if (document.getElementById(initial)) {
    show(initial);
  } else {
    show("s01");
  }

  window.TiabellaUI = { show };
})();
