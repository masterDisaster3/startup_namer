import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange),
      title: "First flutter app follow up!",
      home:const RandomWords(),
        );
  }
}


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {


  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  final _biggerFont = const TextStyle(fontSize: 28);

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
          IconButton(onPressed: _pushSaved,
           icon: const Icon(Icons.list),
           tooltip: "Saved suggestions",
           )
      ],
      title: const Text("Startup names"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i ){
           if(i.isOdd) return const Divider();
    
           final index = i ~/ 2;
           if(index >= _suggestions.length){
             _suggestions.addAll(generateWordPairs().take(10));
    
           }
    
           final alreadySaved = _saved.contains(_suggestions[index]);
    
           return ListTile(
             title: Text(_suggestions[index].asCamelCase,
             style: _biggerFont,),
             trailing: Icon(
               alreadySaved ? Icons.favorite : Icons.favorite_border,
               color: alreadySaved ? Colors.black : null,
               semanticLabel: alreadySaved ? "Remove form saved" : "Save",  
             ),
             onTap: (){
               setState(() {
                 if(alreadySaved){
                   _saved.remove(_suggestions[index]);
                 }
                 else _saved.add(_suggestions[index]);
               });
             },
           );
    
            
        }),
    )
    ;
  }
}
