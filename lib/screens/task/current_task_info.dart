import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task/task_tile.dart';

class CurrentTaskInfo extends StatefulWidget {
  @override
  _CurrentTaskInfoState createState() => _CurrentTaskInfoState();
}

class _CurrentTaskInfoState extends State<CurrentTaskInfo> {

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    int tasksCount = tasks.length;

    return Column(
      children: <Widget>[
        tasksCount != 0
            ? Container(
                height: 180,
                // padding: EdgeInsets.all(15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
                  },
                ),
              )
            : Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text("You do not have an active task. Click the add button to add a new task."),
            ),
      ],
    );
  }
}
