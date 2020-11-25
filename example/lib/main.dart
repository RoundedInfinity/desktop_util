import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desktop app',
      showSemanticsDebugger: false,
      theme: ThemeData(splashFactory: InkRipple.splashFactory,),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}
