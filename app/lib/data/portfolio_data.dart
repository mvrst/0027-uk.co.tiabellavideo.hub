import 'package:flutter/material.dart';

import '../models/portfolio_item.dart';

List<Color> _g(Color a, Color b) => [a, b];

/// Local catalog — titles from docs/routes / 0027.pen labels.
abstract final class PortfolioData {
  static const _c1 = Color(0xFF2D3436);
  static const _c2 = Color(0xFF636E72);
  static const _c3 = Color(0xFF74B9FF);
  static const _c4 = Color(0xFF0984E3);
  static const _c5 = Color(0xFFD63031);
  static const _c6 = Color(0xFFE17055);

  static final List<PortfolioItem> all = [
    PortfolioItem(
      id: 'corporate_campaign',
      title: 'Corporate Campaign',
      gradient: _g(_c1, _c2),
      tileTestKey: 'TK_S05_TILE_CORPORATE_CAMPAIGN',
    ),
    PortfolioItem(
      id: 'broadcast_studio',
      title: 'Broadcast Studio',
      gradient: _g(_c3, _c4),
      tileTestKey: 'TK_S05_TILE_BROADCAST_STUDIO',
    ),
    PortfolioItem(
      id: 'documentary_film',
      title: 'Documentary Film',
      gradient: _g(_c2, _c1),
      tileTestKey: 'TK_S05_TILE_DOCUMENTARY_FILM',
    ),
    PortfolioItem(
      id: 'product_showcase',
      title: 'Product Showcase',
      gradient: _g(_c5, _c6),
      tileTestKey: 'TK_S05_TILE_PRODUCT_SHOWCASE',
    ),
    PortfolioItem(
      id: 'event_coverage',
      title: 'Event Coverage',
      gradient: _g(_c4, _c3),
      tileTestKey: 'TK_S05_TILE_EVENT_COVERAGE',
    ),
    PortfolioItem(
      id: 'brand_identity',
      title: 'Brand Identity',
      gradient: _g(_c6, _c5),
      tileTestKey: 'TK_S05_TILE_BRAND_IDENTITY',
    ),
  ];

  static final List<PortfolioItem> production = [
    PortfolioItem(
      id: 'commercial_shoot',
      title: 'Commercial Shoot',
      subtitle: 'Multi-location production',
      gradient: _g(_c1, _c4),
      tileTestKey: 'TK_S05B_TILE_COMMERCIAL_SHOOT',
    ),
    PortfolioItem(
      id: 'music_video',
      title: 'Music Video',
      subtitle: 'Full crew, location shoot',
      gradient: _g(_c5, _c1),
      tileTestKey: 'TK_S05B_TILE_MUSIC_VIDEO',
    ),
    PortfolioItem(
      id: 'documentary_series',
      title: 'Documentary Series',
      subtitle: '4-part documentary',
      gradient: _g(_c2, _c3),
      tileTestKey: 'TK_S05B_TILE_DOCUMENTARY_SERIES',
    ),
    PortfolioItem(
      id: 'live_event_capture',
      title: 'Live Event Capture',
      subtitle: 'Multi-camera live event',
      gradient: _g(_c4, _c6),
      tileTestKey: 'TK_S05B_TILE_LIVE_EVENT_CAPTURE',
    ),
  ];

  static final List<PortfolioItem> postProduction = [
    PortfolioItem(
      id: 'colour_grading',
      title: 'Colour Grading',
      subtitle: 'Feature-grade grade suite',
      gradient: _g(_c1, _c5),
      tileTestKey: 'TK_S05C_TILE_COLOUR_GRADING',
    ),
    PortfolioItem(
      id: 'motion_graphics',
      title: 'Motion Graphics',
      subtitle: 'Animated brand package',
      gradient: _g(_c3, _c2),
      tileTestKey: 'TK_S05C_TILE_MOTION_GRAPHICS',
    ),
    PortfolioItem(
      id: 'sound_design',
      title: 'Sound Design',
      subtitle: 'Full audio post suite',
      gradient: _g(_c6, _c4),
      tileTestKey: 'TK_S05C_TILE_SOUND_DESIGN',
    ),
    PortfolioItem(
      id: 'editing_assembly',
      title: 'Editing & Assembly',
      subtitle: 'Narrative-led edit',
      gradient: _g(_c2, _c1),
      tileTestKey: 'TK_S05C_TILE_EDITING_ASSEMBLY',
    ),
  ];

  static final List<PortfolioItem> corporate = [
    PortfolioItem(
      id: 'brand_launch_film',
      title: 'Brand Launch Film',
      subtitle: 'National brand campaign',
      gradient: _g(_c1, _c3),
      tileTestKey: 'TK_S05D_TILE_BRAND_LAUNCH_FILM',
    ),
    PortfolioItem(
      id: 'executive_interviews',
      title: 'Executive Interviews',
      subtitle: 'Studio & location format',
      gradient: _g(_c4, _c2),
      tileTestKey: 'TK_S05D_TILE_EXECUTIVE_INTERVIEWS',
    ),
    PortfolioItem(
      id: 'annual_report_video',
      title: 'Annual Report Video',
      subtitle: 'Stakeholder communications',
      gradient: _g(_c5, _c6),
      tileTestKey: 'TK_S05D_TILE_ANNUAL_REPORT_VIDEO',
    ),
    PortfolioItem(
      id: 'training_programme',
      title: 'Training Programme',
      subtitle: 'L&D series, 8 modules',
      gradient: _g(_c3, _c5),
      tileTestKey: 'TK_S05D_TILE_TRAINING_PROGRAMME',
    ),
  ];

  static PortfolioItem? byId(String? id) {
    if (id == null || id.isEmpty) return defaultPreview;
    final allLists = [...all, ...production, ...postProduction, ...corporate];
    for (final p in allLists) {
      if (p.id == id) return p;
    }
    return defaultPreview;
  }

  /// Design default when `project_id` omitted.
  static PortfolioItem get defaultPreview => PortfolioItem(
        id: 'corporate_campaign',
        title: 'Corporate Campaign — Brand Launch',
        subtitle:
            'Full production from concept development through to final delivery. Multi-location shoot with post-production editing and colour grading.',
        tags: const ['Production', '2024'],
        gradient: _g(_c1, _c2),
        tileTestKey: 'TK_S05_TILE_CORPORATE_CAMPAIGN',
      );
}
