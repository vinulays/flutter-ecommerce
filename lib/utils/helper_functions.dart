import 'package:flutter/material.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    if (value == "white") {
      return Colors.white;
    } else if (value == "black") {
      return Colors.black.withOpacity(0.35);
    } else if (value == "blue") {
      return Colors.blue;
    } else if (value == "green") {
      return Colors.green;
    } else if (value == "red") {
      return Colors.red;
    }

    return Colors.white;
  }
}
