import 'package:flutter/material.dart';

class PortfolioItem {
  const PortfolioItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.tags = const [],
    required this.gradient,
    required this.tileTestKey,
  });

  final String id;
  final String title;
  final String? subtitle;
  final List<String> tags;
  final List<Color> gradient;
  /// Full ValueKey string e.g. TK_S05_TILE_CORPORATE_CAMPAIGN
  final String tileTestKey;
}
