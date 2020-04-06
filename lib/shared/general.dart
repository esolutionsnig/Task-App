import 'package:flutter/material.dart';
import 'package:tasks/shared/color.dart';

const textInputDecoration = InputDecoration(
  fillColor: cFormFillColor,
  filled: true,
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: cDarkPink4, width: 2)),
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: cWhite, width: 2)),
);

Widget title() {
  return Stack(
    children: <Widget>[
      Text(
        "task",
        style: TextStyle(fontSize: 61, color: cDarkPink4),
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

// Header Image
Widget header(String imageLocation) {
  return Image.asset(imageLocation);
}

Widget homeTitle() {
  return Stack(
    children: <Widget>[
      Text(
        "task",
        style: TextStyle(fontSize: 40, color: cWhite),
      ),
    ],
  );
}

Widget inforTitle(String title) {
  return Container(
    margin: EdgeInsets.only(top: 30, bottom: 10),
    child: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
  );
}


Widget formTitle(String title, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 30, bottom: 10),
    child: Text(
      title,
      style: TextStyle(fontSize: 24, color: color),
    ),
  );
}

// Divider
Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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

const pinkGradient = LinearGradient(
  colors: <Color>[cDarkPink4, cDarkPink2, cDarkPink1],
  stops: [0.0, 0.5, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const redGradient = LinearGradient(
  colors: <Color>[cDarkRed, cLiteRed],
  stops: [0.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const USER_IMAGE='https://cdn4.iconfinder.com/data/icons/people-avatar-flat-1/64/girl_chubby_beautiful_people_woman_lady_avatar-512.png';
const TASK_IMAGE='https://cdn4.iconfinder.com/data/icons/people-avatar-flat-1/64/girl_chubby_beautiful_people_woman_lady_avatar-512.png';
const MALE_ICON ='https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/maleicon.png?alt=media&token=1733742c-4ece-4c0f-8def-ff79fdfb2ff8';
const FEMALE_ICON ='https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/femaleicon.png?alt=media&token=852d21a8-b6d5-4445-8c58-7a53aadd2618';
const NEW_USER_ICON ='https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/newusericon.png?alt=media&token=fc4e5092-1a8f-4f75-a9ab-6820ead55d7e';
