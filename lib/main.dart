import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async{
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NumberTriviaPage());
  }
}
