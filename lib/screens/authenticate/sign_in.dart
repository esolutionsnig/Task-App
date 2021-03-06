import 'package:flutter/material.dart';
import 'package:tasks/screens/authenticate/sign_up.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/shared/loading.dart';
import 'package:tasks/widget/bezierContainer.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            dynamic result =
                await _authService.signInWithEmailAndPassword(email, password);
            if (result == null) {
              setState(() {
                loading = false;
                hasError = true;
                error = 'Could not sign with those credentials.';
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
                minHeight: 36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text(
              'Sign In'.toUpperCase(),
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
                          inforTitle("Sign in with your email & password"),
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
