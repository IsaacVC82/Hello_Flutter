import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  late final WordPair current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello World'),
            Text(appState.current.asLowerCase),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContainer(),
                SizedBox(width: 20),
                _buildStack(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Container')),
    );
  }

  Widget _buildStack() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: Center(child: Text('Text')),
          ),
        ),
      ],
    );
  }
}
