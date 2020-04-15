import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';

class TaskListTile extends StatefulWidget {
  final Task task;
  TaskListTile({Key key, @required this.task}) : super(key: key);
  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  bool loading = false;
  bool endedCompletely = false;
  bool checkExpired = false;

  // get task duration and count down
  var startDateTime,
      endDateTime,
      remainingSeconds,
      remainingSeconds2,
      duration,
      now;

  void taskDurationCountDown() {
    now = DateTime.now();
    startDateTime = widget.task.startDateTime.toDate();
    endDateTime = widget.task.endDateTime.toDate();
    remainingSeconds = endDateTime.difference(now).inSeconds;

    if (remainingSeconds < 0) {
      checkExpired = true;
      if (widget.task.status == "Completed") {
        endedCompletely = true;
      } else if (widget.task.status == "Started") {
        endedCompletely = false;
      }
    } else {
      checkExpired = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    taskDurationCountDown();
    return InkWell(
      onTap: () {
        _showTaskInfo(context);
      },
      child: Card(
        color: checkExpired
            ? endedCompletely ? cTealLite5 : cRedLite5
            : cFormFillColor,
        child: ListTile(
          leading: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(TASK_IMAGE),
                radius: 15.0,
              ),
              SizedBox(
                height: 5,
              ),
              checkExpired
                  ? endedCompletely
                      ? Text(
                          "",
                          style: TextStyle(
                            color: cRed,
                            fontSize: 1.0,
                          ),
                        )
                      : Text(
                          "Elapsed",
                          style: TextStyle(
                            color: cRed,
                            fontSize: 8.0,
                          ),
                        )
                  : Text(
                      "",
                      style: TextStyle(
                        color: cRed,
                        fontSize: 1.0,
                      ),
                    ),
              widget.task.status == "Not Started"
                  ? Text(
                      widget.task.status,
                      style: TextStyle(
                        color: cRed,
                        fontSize: 8.0,
                      ),
                    )
                  : widget.task.status == "Started"
                      ? Text(
                          widget.task.status,
                          style: TextStyle(
                            color: cBlack,
                            fontSize: 8.0,
                          ),
                        )
                      : Text(
                          widget.task.status,
                          style: TextStyle(
                            color: cTeal,
                            fontSize: 8.0,
                          ),
                        ),
            ],
          ),
          title: Text(
            widget.task.title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          subtitle: Text(
            widget.task.description.length < 70 ? '${widget.task.description}' : '${widget.task.description}'.substring(0, 70) + '...',
          ),
        ),
      ),
    );
  }

  // Bottom Sheet
  _showTaskInfo(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 600.0,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: widget.task == null
              ? Text('')
              : ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 15.0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 8.0, bottom: 8.0, left: 8.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    '${widget.task.status} \n',
                                                style: TextStyle(
                                                  color: widget.task.status ==
                                                          'Completed'
                                                      ? cTeal
                                                      : widget.task.status ==
                                                              'Started'
                                                          ? cDarkPink2
                                                          : cRed,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: widget.task.title,
                                                    style: TextStyle(
                                                      color: cBlack,
                                                      fontSize: 15.0,
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
                                color: widget.task.priority == 'HIGH'
                                    ? cHigh
                                    : widget.task.priority == 'MEDIUM'
                                        ? cMedium
                                        : cLow,
                                size: 36,
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.98,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${widget.task.description}\n',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            text:
                                                'Date: ${widget.task.startDateTime.toDate()}'
                                                    .substring(0, 16),
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nTime: ' +
                                                ': ${widget.task.startDateTime.toDate()}'
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
                                            text:
                                                'Date: ${widget.task.endDateTime.toDate()}'
                                                    .substring(0, 16),
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nTime: ' +
                                                ': ${widget.task.endDateTime.toDate()}'
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
                                onPressed: () async {
                                  if (this.mounted) {
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  await DatabaseService()
                                      .deleteTask(widget.task.id);
                                  if (this.mounted) {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: whiteGradient,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80.0)),
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
                              widget.task.status == 'Completed'
                                  ? Text('')
                                  : Container(
                                      child: widget.task.status == "Started"
                                          ? RaisedButton(
                                              onPressed: () async {
                                                if (this.mounted) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                }
                                                await DatabaseService()
                                                    .markTaskCompleted(
                                                        widget.task.id,
                                                        "Completed");
                                                if (this.mounted) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                              ),
                                              padding: EdgeInsets.all(0.0),
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  gradient: pinkGradient,
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                          fontWeight:
                                                              FontWeight.w300,
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
                                              onPressed: () async {
                                                if (this.mounted) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                }
                                                DatabaseService()
                                                    .markTaskStarted(
                                                        widget.task.id,
                                                        'Started');
                                                if (this.mounted) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                              ),
                                              padding: EdgeInsets.all(0.0),
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  gradient: pinkGradient,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              80.0)),
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
                                                          fontWeight:
                                                              FontWeight.w300,
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
                                    widget.task.priority,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: widget.task.priority == 'HIGH'
                                          ? cHigh
                                          : widget.task.priority == 'MEDIUM'
                                              ? cMedium
                                              : cLow,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
