import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/user.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  String _priority;
  String _status;
  DateTime _startDateTime;
  DateTime _endDateTime;
  int selectedPriority;
  bool isHigh = false;
  bool isMedium = false;
  bool isLow = false;
  bool status = false;
  String error = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    selectedPriority = 0;
  }

  setSelectedPriority(int val) {
    if (val == 0) {
      setState(() {
        isHigh = true;
        isMedium = false;
        isLow = false;
      });
    } else if (val == 1) {
      setState(() {
        isHigh = false;
        isMedium = true;
        isLow = false;
      });
    } else if (val == 2) {
      setState(() {
        isHigh = false;
        isMedium = false;
        isLow = true;
      });
    }
    setState(() {
      selectedPriority = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                  Icons.list,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              formTitle(
                "Add New Task",
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
                  "All fields are required.",
                  style: TextStyle(
                    color: cYellow,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Title",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() {
                    _title = val;
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() {
                    _description = val;
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      color: cDarkPink2,
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 4, 5, 23, 59),
                          theme: DatePickerTheme(
                            backgroundColor: cDarkPink2,
                            headerColor: cDarkPink4,
                            itemStyle: TextStyle(
                              color: cWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            doneStyle: TextStyle(
                              color: cWhite,
                              fontSize: 18,
                            ),
                            cancelStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                          ),
                          onChanged: (date) {
                            setState(() {
                              _startDateTime = date;
                            });
                          },
                          onConfirm: (date) {
                            setState(() {
                              _startDateTime = date;
                            });
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      child: Text(
                        'STARTING',
                        style: TextStyle(color: cWhite),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _startDateTime == null
                        ? Text('Click button to add date & time')
                        : Text(
                            "$_startDateTime",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      color: cDarkPink2,
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 4, 5, 23, 59),
                          theme: DatePickerTheme(
                            backgroundColor: cDarkPink2,
                            headerColor: cDarkPink4,
                            itemStyle: TextStyle(
                              color: cWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            doneStyle: TextStyle(
                              color: cWhite,
                              fontSize: 18,
                            ),
                            cancelStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                          ),
                          onChanged: (date) {
                            setState(() {
                              _endDateTime = date;
                            });
                          },
                          onConfirm: (date) {
                            setState(() {
                              _endDateTime = date;
                            });
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      child: Text(
                        'ENDING',
                        style: TextStyle(color: cWhite),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _endDateTime == null
                        ? Text('Click button to add date & time')
                        : Text(
                            "$_endDateTime",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Priority",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                RadioListTile(
                  value: 0,
                  groupValue: selectedPriority,
                  activeColor: Theme.of(context).primaryColor,
                  title: Text("HIGH: Extremely Importane"),
                  selected: isHigh,
                  onChanged: (val) {
                    setSelectedPriority(val);
                  },
                ),
                RadioListTile(
                  value: 1,
                  groupValue: selectedPriority,
                  activeColor: Theme.of(context).primaryColor,
                  title: Text("MEDIUM: Slightly Important"),
                  selected: isMedium,
                  onChanged: (val) {
                    setSelectedPriority(val);
                  },
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedPriority,
                  activeColor: Theme.of(context).primaryColor,
                  title: Text("LOW: Just Important"),
                  selected: isLow,
                  onChanged: (val) {
                    setSelectedPriority(val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Task Status: ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomSwitch(
                          activeColor: cDarkPink3,
                          value: status,
                          onChanged: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          '(On = Started | Off = Not Started)',
                          style: TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                  ],
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
                setState(() {
                  loading = true;
                });
                if (_title != null ||
                    _description != null ||
                    _startDateTime != null ||
                    _endDateTime != null) {
                  if (status == true) {
                    _status = "Started";
                  } else {
                    _status = "Not Started";
                  }
                  if (selectedPriority == 0) {
                    _priority = "HIGH";
                  } else if (selectedPriority == 1) {
                    _priority = "MEDIUM";
                  } else if (selectedPriority == 2) {
                    _priority = "LOW";
                  }
                  await DatabaseService().addUserTask(
                    user.uid,
                    _title,
                    _description,
                    _startDateTime,
                    _endDateTime,
                    _priority,
                    _status,
                  );
                  setState(() {
                    loading = false;
                  });
                  Navigator.pop(context);
                } else {
                  setState(() {
                    error = "Kindly enter all required fields.";
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
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
                    'Save Task'.toUpperCase(),
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
          loading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 20.0,
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Processing...",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                )
              : Text(''),
          Text(
            error,
            style: TextStyle(
              fontSize: 17,
              color: cRed,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
