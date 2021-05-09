import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ColorPalette {
  static const Color primaryColor = Color.fromRGBO(0, 169, 224, 1);
  static const Color primaryColorLight = Color.fromRGBO(164, 215, 244, 1);
  static const Color primaryColorDark = Color.fromRGBO(9, 28, 90, 1);
  static const Color primaryColorDarkLight = Color.fromRGBO(0, 85, 150, 1);
  static const Color accentColor = Color.fromRGBO(227, 24, 55, 1);
  static const Color primaryBackgroundColor = Color.fromRGBO(255, 255, 255, 1);

  static const Color greyLight = Color(0xFFe6e6e6);
  static const Color greyIcon = Color(0xFFcccccc);
  static Color greyDarkIcon = Colors.blueGrey[700];

  static const Color successColor = Colors.green;

  static const Color red = Color(0xFFb40a1a);

  //text colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static Color greyText = Colors.blueGrey[800];
  static const Color darkGreyText = Colors.black87;
  static const Color greyDisabled = Color(0xFFb5b3b3);

  static const Color canvas = white;
  static const Color darkBlue = primaryColorDark;
  static const Color lightBlue = primaryColorDarkLight;
}
