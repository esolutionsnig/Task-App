import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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

Widget getDateTimeShimmer() {
  return Shimmer.fromColors(
    baseColor: cFormFillColor,
    highlightColor: cWhite3,
    child: Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: cWhite3,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: 250.0,
              height: 15.0,
              decoration: BoxDecoration(
                  color: cWhite3, borderRadius: BorderRadius.circular(25.0)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getShimmer() {
  return Shimmer.fromColors(
    baseColor: cFormFillColor,
    highlightColor: cDarkPink2,
    child: Row(
      children: <Widget>[
        Container(
          width: 65.0,
          height: 65.0,
          margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 0.0),
          child: Icon(
            Icons.account_box,
            size: 60,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 160.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: cDarkPink2,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: 160.0,
              height: 30.0,
              decoration: BoxDecoration(
                  color: cDarkPink2, borderRadius: BorderRadius.circular(25.0)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget headerTextVertical(String title, int total) {
  return Container(
    margin: EdgeInsets.only(top: 33.0, bottom: 2.0, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '$title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '$total',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: cDarkPink2,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget headerText(String title, int total) {
  return Container(
    margin: EdgeInsets.only(top: 14.0, bottom: 2.0, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '$title:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              '$total',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: cDarkPink2,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.arrow_back_ios,
              size: 16.0,
              color: cDarkPink3,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
              color: cDarkPink3,
            ),
          ],
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

const whiteGradient = LinearGradient(
  colors: <Color>[cWhite3, cWhite2, cWhite1],
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

const USER_IMAGE =
    'https://cdn4.iconfinder.com/data/icons/people-avatar-flat-1/64/girl_chubby_beautiful_people_woman_lady_avatar-512.png';
const TASK_IMAGE =
    'https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/taskIcon.png?alt=media&token=1ec9f338-39a5-4e86-9235-a664cb3b5a79';
const MALE_ICON =
    'https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/maleicon.png?alt=media&token=1733742c-4ece-4c0f-8def-ff79fdfb2ff8';
const FEMALE_ICON =
    'https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/femaleicon.png?alt=media&token=852d21a8-b6d5-4445-8c58-7a53aadd2618';
const NEW_USER_ICON =
    'https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/newusericon.png?alt=media&token=fc4e5092-1a8f-4f75-a9ab-6820ead55d7e';
