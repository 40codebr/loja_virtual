import 'package:flutter/material.dart';

    final ThemeData base = new ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.red[900],
      primaryColor: Color(0xFF30903D),
      buttonColor: Color(0xFF15130F),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF15130F),
        disabledColor: Color(0xFF15130F).withAlpha(100),
        textTheme: ButtonTextTheme.normal,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
      ),
      scaffoldBackgroundColor: Color(0xFFE5E8EF),
      cardColor: Colors.white,
      errorColor: Color(0xFF2B292A),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: Color(0xFF15130F)),
        bodyText2: TextStyle(color: Colors.grey[700]),
        headline1: TextStyle(color: Colors.pink),
        headline2: TextStyle(color: Colors.blue),
        headline3: TextStyle(color: Colors.redAccent),
        headline4: TextStyle(color: Colors.yellow),
        headline5: TextStyle(color: Colors.teal),
        headline6: TextStyle(color: Colors.white),
      ),
      accentTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.purple)),
      // primaryIconTheme: base.iconTheme.copyWith(color: Colors.yellow),
    );
  

