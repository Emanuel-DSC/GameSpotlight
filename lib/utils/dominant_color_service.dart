import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'dominant_color_cache.dart';

class DominantColorService {
  static Future<Color> getColor(String url) async {
    if (dominantColorCache.containsKey(url)) {
      return dominantColorCache[url]!;
    }

    try {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(url),
        size: const Size(200, 200),
        maximumColorCount: 8,
      );

      final color = palette.dominantColor?.color ?? Colors.grey[900]!;

      final adjusted = color.withValues(alpha: .9);
      dominantColorCache[url] = adjusted;
      return adjusted;
    } catch (e) {
      return Colors.grey[900]!;
    }
  }
}
