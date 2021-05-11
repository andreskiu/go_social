import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/injectable/injectable.dart';
import 'config/localizations/app_localizations.dart';
import 'presentation/activities/activities_page.dart';
import 'presentation/activities/new_activity_page.dart';
import 'presentation/activities/view_activity_page.dart';
import 'presentation/core/style/color_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: ColorPalette.primaryColor,
          primaryColorDark: ColorPalette.primaryColorDark,
          primaryColorLight: ColorPalette.primaryColorLight,
          iconTheme: IconThemeData(
            color: ColorPalette.primaryColorDark,
          ),
          primaryTextTheme: TextTheme(
            headline4: TextStyle(
                color: ColorPalette.white, fontWeight: FontWeight.bold),
            headline6: TextStyle(
              color: ColorPalette.primaryColor,
            ),
            bodyText1: TextStyle(
              color: ColorPalette.primaryColorDark,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: ColorPalette.primaryColorDark,
            ),
            labelStyle: TextStyle(
              color: ColorPalette.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
            errorStyle: TextStyle(
              color: ColorPalette.red,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                ColorPalette.accentColor,
              ),
              backgroundColor: MaterialStateProperty.all(
                ColorPalette.primaryColor,
              ),
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  color: ColorPalette.white,
                ),
              ),
            ),
          )),
      supportedLocales: SUPPORTED_LOCALES,
      localizationsDelegates: [
        // To manage the translation in material widgets like DatePicker.
        GlobalMaterialLocalizations.delegate,
        // The delegate to check if there will be texts in LTR or RTL format.
        GlobalWidgetsLocalizations.delegate,
        // The custom delegate to manage the translations.
        AppLocalizations.delegate
      ],
      home: ActivitiesPage(),
      routes: {
        '/view_activity': (context) => ViewActivityPage(),
        '/new_activity': (context) => NewActivityPage(),
      },
    );
  }
}
