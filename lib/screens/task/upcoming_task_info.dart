import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task/task_tile.dart';
import 'package:tasks/shared/general.dart';

class UpcomingTaskInfo extends StatefulWidget {
  @override
  _UpcomingTaskInfoState createState() => _UpcomingTaskInfoState();
}

class _UpcomingTaskInfoState extends State<UpcomingTaskInfo> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    int tasksCount = tasks.length;

    return Column(
      children: <Widget>[
        headerText("Your Upcoming Tasks", tasksCount),
        tasksCount != 0 ? Container(
          height: 350,
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(task: tasks[index]);
            },
          ),
        ) : Text(""),
      ],
    );
  }
}