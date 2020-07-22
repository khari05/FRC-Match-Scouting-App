import 'package:flutter/material.dart';
import 'package:frc_scouting/src/widgets/AddDialog.dart';
import 'package:frc_scouting/src/widgets/EventView.dart';
// import 'package:frc_scouting/widgets/settings_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
        home:
            MainMenu() // need to put app contents in a subclass in order to be able to call navigator
        );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appbar is the header
        title: Text('Event List'),
        // TODO: Add a settings page
        // actions: [
        //   FlatButton(
        //     child: Icon(Icons.settings),
        //     onPressed: () =>
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       return SettingsPage();
        //     })),
        //   )
        // ],
      ),
      body: Center(child: EventView()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(context: context, builder: (context) => AddDialog());
          }),
    );
  }
}