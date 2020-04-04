import 'package:flutter/material.dart';
import 'package:tasks/screens/authenticate/sign_up.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/widget/bezierContainer.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  String email = '';
  String password = '';

  double pageHorizontalPadding = 50.0;
  double pageVerticalPadding = 10.0;
  double sizeBox = 10.0;

  // Submit button
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Theme.of(context).primaryColor,
        textColor: cWhite,
        onPressed: () {
          print(email);
          print(password);
        },
        child: Text(
          "Sign In".toUpperCase(),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Divider
  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: pageVerticalPadding),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  // Facebook Button
  Widget _googleButton() {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: cRed,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'G',
                style: TextStyle(
                  color: cWhite,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: cFormFillColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Log In With Google".toUpperCase(),
                style: TextStyle(
                  color: cRed,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create Account Label
  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account yet?",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: Text(
              "Sign Up".toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Title
  Widget _title() {
    return Stack(
      children: <Widget>[
        Text(
          "task",
          style: TextStyle(fontSize: 61, color: Theme.of(context).primaryColor),
        ),
        Container(
          margin: EdgeInsets.only(top: 62),
          child: Text(
            "plan your day",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                    _title(),
                    SizedBox(
                      height: 35,
                    ),
                    Form(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: pageVerticalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Email Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: cFormFillColor,
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: pageVerticalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: cFormFillColor,
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          _submitButton(),
                        ],
                      ),
                    ),
                    _divider(),
                    _googleButton(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _createAccountLabel(),
              ),
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
