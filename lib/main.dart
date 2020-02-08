import 'package:flutter/material.dart';

import 'package:github_members_app/screens/main/main_screen.dart'
    show HomeScreen;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Members',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
