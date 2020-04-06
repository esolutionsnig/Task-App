import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/user.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/shared/loading.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String _surname;
  String _firstname;
  String _gender;
  int selectedGender;
  bool isFemale = false;
  bool isMale = false;

  @override
  void initState() {
    super.initState();
    selectedGender = 0;
  }

  setSelectedGender(int val) {
    if (val == 0) {
      setState(() {
        _gender = FEMALE_ICON;
        isFemale = true;
        isMale = false;
      });
    } else {
      setState(() {
        _gender = MALE_ICON;
        isMale = true;
        isFemale = false;
      });
    }
    setState(() {
      selectedGender = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            // if (userData.gender == 0) {
            //   selectedGender = 0;
            // } else {
            //   selectedGender = 1;
            // }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Icon(
                          Icons.person_outline,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      formTitle(
                        "Profile Information",
                        Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Given Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          initialValue: userData.firstname,
                          decoration: textInputDecoration,
                          // validator: (val) => val.isEmpty ? "Please enter your given name" : "",
                          onChanged: (val) => setState(() {
                            _firstname = val;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Family Name (Surname)",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          initialValue: userData.surname,
                          decoration: textInputDecoration,
                          // validator: (val) => val.isEmpty
                          //     ? "Please enter your family name"
                          //     : "",
                          onChanged: (val) => setState(() {
                            _surname = val;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RadioListTile(
                          value: 0,
                          groupValue: selectedGender,
                          activeColor: Theme.of(context).primaryColor,
                          title: Text("Female"),
                          selected: isFemale,
                          onChanged: (val) {
                            setSelectedGender(val);
                          },
                        ),
                        RadioListTile(
                          value: 1,
                          groupValue: selectedGender,
                          activeColor: Theme.of(context).primaryColor,
                          title: Text("Male"),
                          selected: isMale,
                          onChanged: (val) {
                            setSelectedGender(val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _surname ?? userData.surname,
                            _firstname ?? userData.firstname,
                            selectedGender ?? userData.gender,
                            _gender ?? userData.avatar,
                          );
                          Navigator.pop(context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: pinkGradient,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                            'Save Changes'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
