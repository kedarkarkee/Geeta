import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/choice.dart';
import './screens/bookmarks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Geeta',
        home: MyHomePage(),
        routes: {
          '/choice': (ctx) => ChoiceScreen(),
          '/bookmarks': (ctx)=> Bookmarks()
        },
    );
  }
}
