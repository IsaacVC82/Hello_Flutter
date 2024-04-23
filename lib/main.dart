import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Pokémon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonListPage(),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<String> pokemonList = [];
  int offset = 0;
  int limit = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> results = decoded['results'];

        for (var pokemonData in results) {
          final pokemonName = pokemonData['name'];
          setState(() {
            pokemonList.add(pokemonName);
          });
        }

        final nextUrl = decoded['next'];
        if (nextUrl != null) {
          offset += limit;
        }
      } else {
        throw Exception('Error al cargar la lista de Pokémon. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pokémon'),
      ),
      body: pokemonList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pokemonList.length + 1,
              itemBuilder: (context, index) {
                if (index == pokemonList.length) {
                  return isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox.shrink();
                }

                return ListTile(
                  title: Text(pokemonList[index]),
                );
              },
              onEndReached: () {
                fetchPokemonList();
              },
            ),
    );
  }
}
