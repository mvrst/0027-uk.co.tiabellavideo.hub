import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/route_paths.dart';

/// Contract: filter icon = local_state / navigate via category (same as chips).
Future<void> showPortfolioFilterSheet(BuildContext context) {
  final root = context;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetCtx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text(
                'Portfolio categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('All projects'),
              onTap: () {
                Navigator.pop(sheetCtx);
                root.go(RoutePaths.portfolio);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Production'),
              onTap: () {
                Navigator.pop(sheetCtx);
                root.go(RoutePaths.portfolioProduction);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Post-Production'),
              onTap: () {
                Navigator.pop(sheetCtx);
                root.go(RoutePaths.portfolioPostProduction);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_outlined),
              title: const Text('Corporate'),
              onTap: () {
                Navigator.pop(sheetCtx);
                root.go(RoutePaths.portfolioCorporate);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
