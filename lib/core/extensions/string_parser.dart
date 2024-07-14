import 'package:flutter/cupertino.dart';

extension StringParser on String {
  Color toColor() {
    String hashColor = replaceAll("#", "0xff");
    return Color(int.parse(hashColor));
  }
}

extension ColorParser on Color {
  String toHex() {
    return value.toRadixString(16).replaceRange(0, 2, "#");
  }
}
