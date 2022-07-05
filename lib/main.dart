import 'package:flutter/material.dart';
import 'package:project1/theme.bloc.dart';

import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: bloc.darkThemeIsEnabled,
        builder: (context, snapshot) {
          return MaterialApp(
              theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
              home: HomePage(snapshot.data, bloc)
          );
        }
    );
  }
}

final bloc = ThemeBloc();