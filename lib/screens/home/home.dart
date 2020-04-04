import 'package:flutter/material.dart';
import 'package:tasks/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[20],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0.0,
        title: Text("Tasks"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("Sign Out"),
          )
        ],
      ),
    );
  }
}
