import 'package:flutter/material.dart';
import 'package:frc_scouting/widgets/addDialog.dart';
import 'package:frc_scouting/widgets/eventView.dart';

// initialize constants
final String teamNumber = "7451";
final String url = "https://frc-match-scouting.herokuapp.com";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
      home: MainMenu() // need to put app contents in a subclass in order to be able to call navigator
    );
  }
}

class MainMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( // appbar is the header
        title: Text('Event List'),
      ),
      body: Center(
        child: eventView(context)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) => addDialog(context)
          )
        }
      ),
    );
  }
}