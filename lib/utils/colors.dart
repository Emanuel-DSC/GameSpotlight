import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';
Color kBgColor1 = const Color(0xFF13161f);
Color kBgColor2 = const Color(0xFF121212);
Color kButtonColor1 = const Color(0xFF9d39fb);
Color kButtonColor2 = const Color(0xFF6650fd);
Color kCardColor = const Color(0xFF1d2027);
Color kSearchBarColor = const Color(0xFF393558);

class ColorUtils {
  static Color getTextColor(Color bg) {
    // Se cor for clara, retorna preto, senão branco
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
