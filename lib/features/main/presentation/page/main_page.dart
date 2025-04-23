import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Main page')));
  }
}
