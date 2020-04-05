import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/user.dart';
import 'package:tasks/screens/wrapper.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/shared/color.dart';

void main() => runApp(MyApp());

final ThemeData _tasksTheme = _buildTasksTheme();

ThemeData _buildTasksTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: cDarkPink3,
    primaryColor: cDarkPink4,
    buttonColor: cDarkPink4,
    scaffoldBackgroundColor: cScaffold,
    cardColor: cWhite,
    canvasColor: Colors.transparent,
    textSelectionColor: cGrey,
    errorColor: cDarkPink3,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: cDarkPink4),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: TextTheme(title: TextStyle(color: cDarkPink4)),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Quicksand',
        displayColor: cText,
        bodyColor: cText,
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Prevent screen from rotating
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _tasksTheme,
        home: Wrapper(),
      ),
    );
  }
}
