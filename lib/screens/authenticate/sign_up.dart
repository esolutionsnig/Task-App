import 'package:flutter/material.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/shared/loading.dart';
import 'package:tasks/widget/bezierContainer.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool hasError = false;

  double pageHorizontalPadding = 50.0;
  double pageVerticalPadding = 10.0;
  double sizeBox = 10.0;

  // Back Button
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  // Submit button
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            dynamic result = await _authService.registerWithEmailAndPassword(
                email, password);
            if (result == null) {
              setState(() {
                loading = false;
                hasError = true;
                error = 'Please enter a valid credential';
              });
            }
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: pinkGradient,
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            constraints: BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0,
            ), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text(
              'Create Account'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
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
            "Already have an account?",
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
              Navigator.pop(context);
            },
            child: Text(
              "Sign In".toUpperCase(),
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
            style: TextStyle(fontSize: 18, color: cDarkPink3),
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
                child: loading
                    ? Loading()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                          header("assets/appicon.png"),
                          inforTitle(
                              "Sign up using your email & password"),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: pageVerticalPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) => val.isEmpty
                                            ? "Enter a valid email address"
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            email = val;
                                          });
                                        },
                                        decoration:
                                            textInputDecoration.copyWith(
                                                hintText: "Email Address"),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: pageVerticalPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        validator: (val) => val.length < 8
                                            ? "Password must be minimum of 8  characters"
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            password = val;
                                          });
                                        },
                                        decoration: textInputDecoration
                                            .copyWith(hintText: "Password"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                _submitButton(),
                                hasError
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          error,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0.1,
                                      ),
                              ],
                            ),
                          ),
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
                top: 40,
                left: 0,
                child: _backButton(),
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
