import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      margin: EdgeInsets.only(bottom: 20.0),
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
                        padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: '${task.status} \n',
                                style: TextStyle(
                                  color:
                                      task.status == 'Started' ? cTeal : cRed,
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
                                  TextSpan(
                                    text: '\n${task.description}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\nSTART: ${task.startDateTime.toDate()}'
                                            .substring(0, 25),
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nEND: ${task.endDateTime.toDate()}'
                                        .substring(0, 25),
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
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
              Icon(
                LineAwesomeIcons.tasks,
                color: task.priority == 'HIGH'
                    ? cHigh
                    : task.priority == 'MEDIUM' ? cMedium : cLow,
                size: 36,
              ),
            ],
          ),
          Divider(
            color: Colors.pink.withAlpha(70),
            height: 3,
            thickness: 1,
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  print(task.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0,
                    ), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: cGrey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                onPressed: () {
                  print(task.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: pinkGradient,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0,
                    ), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text(
                      'Start',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
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
    );
  }
}

// Get Current Task
class CurrentTaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    // Get The First Task
    var currentTask = tasks[0];
    return Positioned(
      bottom: -60,
      child: Container(
        height: 135.0,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5.5,
              blurRadius: 5.5,
            )
          ],
        ),
        child: _currentTaskCard(context, currentTask),
      ),
    );
  }

  Container _currentTaskCard(context, Task taskItem) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.61,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'You should be working on this task\n',
                        style: TextStyle(
                          color: cDarkPink3,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: taskItem.title,
                            style: TextStyle(
                              color: cBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\n${taskItem.description}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: '\nEXPIRES: ${taskItem.endDateTime.toDate()}'
                                .substring(0, 25),
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    print(taskItem.id);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.settings_power,
                        color: cDarkPink3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "End".toUpperCase(),
                        style: TextStyle(color: cDarkPink3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Get Next Task
class NextTaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    // Get The First Task
    var nextTask = tasks[1];
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your Next Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Upcoming: ${tasks.length}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: cDarkPink2,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
          decoration: BoxDecoration(
            color: Colors.pink.withAlpha(30),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: cDarkPink3,
                    backgroundImage: NetworkImage(TASK_IMAGE),
                    radius: 20.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${nextTask.status} \n',
                      style: TextStyle(
                        color: nextTask.status == 'Started' ? cTeal : cRed,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: nextTask.title,
                          style: TextStyle(
                            color: cBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '\n${nextTask.description}',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: '\nSTART: ${nextTask.startDateTime.toDate()}'
                              .substring(0, 25),
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: '\nEND: ${nextTask.endDateTime.toDate()}'
                              .substring(0, 25),
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                color: Colors.pink.withAlpha(70),
                height: 3,
                thickness: 1,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
                      print(nextTask.id);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: whiteGradient,
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0,
                        ), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: cGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(nextTask.id);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: pinkGradient,
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0,
                        ), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Start',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    nextTask.priority,
                    style: TextStyle(
                      fontSize: 15,
                      color: nextTask.priority == 'HIGH'
                          ? cHigh
                          : nextTask.priority == 'MEDIUM' ? cMedium : cLow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
