import 'package:flutter/material.dart';
import 'package:tasks/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();

  double pageHorizontalPadding = 50.0;
  double pageVerticalPadding = 15.0;
  double sizeBox = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[20],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0.0,
        title: Text("Sign In"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: pageVerticalPadding, horizontal: pageHorizontalPadding,),
        child: RaisedButton(
          child: Text("Sign In Anonymously"),
          onPressed: () async {
            dynamic result = await _authService.signInAnon();
            if (result == null) {
              print("Error signing in");
            } else {
              print("Signed in");
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}