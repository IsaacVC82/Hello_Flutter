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
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/background_image.jpg', // Ruta de la imagen
            fit: BoxFit.cover, // Ajustar la imagen para cubrir toda la pantalla
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  appState.current.asLowerCase,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
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
          // Icono en la esquina superior derecha
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.star,
              color: Colors.yellow,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Container',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
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
            child: Center(
              child: Text(
                'Text',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
