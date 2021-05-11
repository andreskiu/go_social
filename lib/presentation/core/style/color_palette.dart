import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ColorPalette {
  static const Color primaryColor = Color(0xffe83e8c);
  static const Color primaryColorLight = Color.fromRGBO(164, 215, 244, 1);
  static const Color primaryColorDark = Color(0xff002149);
  static const Color primaryColorDarkLight = Color(0xff086d84);
  static const Color accentColor = Color(0xff800080);
  static const Color primaryBackgroundColor = Color.fromRGBO(255, 255, 255, 1);

  static const Color greyLight = Color(0xFFe6e6e6);
  static const Color greyIcon = Color(0xFFcccccc);
  static Color greyDarkIcon = primaryColorDark;

  static const Color successColor = Colors.green;

  static const Color red = Color(0xFFb40a1a);

  //text colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  static const Color canvas = white;
  static const Color darkBlue = primaryColorDark;
  static const Color lightBlue = primaryColorDarkLight;
}
