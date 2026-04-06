import 'package:flutter/material.dart';

import 'hub_colors.dart';

/// Decorative status row (design shows 9:41 + signal icons).
class HubStatusBar extends StatelessWidget {
  const HubStatusBar({super.key, this.dark = false});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final fg = dark ? Colors.white : HubColors.charcoal;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: fg,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, size: 18, color: fg),
              const SizedBox(width: 6),
              Icon(Icons.wifi, size: 18, color: fg),
              const SizedBox(width: 6),
              Icon(Icons.battery_full, size: 18, color: fg),
            ],
          ),
        ],
      ),
    );
  }
}
