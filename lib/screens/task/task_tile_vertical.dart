import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';

class TaskTileVertical extends StatelessWidget {
  final Task task;
  TaskTileVertical({this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      margin: EdgeInsets.only(bottom: 20.0, right: 0.0),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: cFormFillColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: cDarkPink3,
                    backgroundImage: NetworkImage(TASK_IMAGE),
                    radius: 20.0,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            right: 10.0, bottom: 16.0, left: 16.0),
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: '${task.status} \n',
                                style: TextStyle(
                                  color: task.status == 'Completed'
                                      ? cTeal
                                      : task.status == 'Started'
                                          ? cPurple
                                          : cRed,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: task.title,
                                    style: TextStyle(
                                      color: cBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${task.description}\n',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Start Date & Time\n',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Date: ${task.startDateTime.toDate()}'
                                .substring(0, 16),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '\nTime: ' +
                                ': ${task.startDateTime.toDate()}'
                                    .substring(13, 18),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'End Date & Time\n',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Date: ${task.endDateTime.toDate()}'
                                .substring(0, 16),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '\nTime: ' +
                                ': ${task.endDateTime.toDate()}'
                                    .substring(13, 18),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Divider(
              color: cWhite,
              height: 3,
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  DatabaseService().deleteTask(task.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0,
                    ), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete_forever,
                          color: cRed,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: cRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              task.status == 'Completed' ? Text('') : Container(
                child: task.status == "Started"
                    ? RaisedButton(
                        onPressed: () {
                          DatabaseService()
                              .markTaskCompleted(task.id, "Completed");
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: pinkGradient,
                            borderRadius: BorderRadius.all(
                              Radius.circular(80.0),
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 88.0,
                              minHeight: 36.0,
                            ), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.stop,
                                  color: cWhite,
                                ),
                                Text(
                                  'End',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : RaisedButton(
                        onPressed: () {
                          DatabaseService().markTaskStarted(task.id, 'Started');
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
                              minHeight: 36.0,
                            ), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: cWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Priority"),
                  ),
                  Text(
                    task.priority,
                    style: TextStyle(
                      fontSize: 15,
                      color: task.priority == 'HIGH'
                          ? cHigh
                          : task.priority == 'MEDIUM' ? cMedium : cLow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}