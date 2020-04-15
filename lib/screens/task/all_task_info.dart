import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task/task_list_tile.dart';
import 'package:tasks/shared/general.dart';

class AllTaskInfo extends StatefulWidget {
  @override
  _AllTaskInfoState createState() => _AllTaskInfoState();
}

class _AllTaskInfoState extends State<AllTaskInfo> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    int tasksCount = tasks.length;

    return Column(
      children: <Widget>[
        tasksCount != 0 ? taskDivider() : Text(""),
        tasksCount != 0 ? headerText("All Tasks", tasksCount) : Text(""),
        tasksCount != 0
            ? Container(
                height: 600,
                padding: EdgeInsets.only(top: 15.0, right: 15.0, bottom: 30.0, left: 15.0),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListTile(task: tasks[index]);
                  },
                ),
              )
            : Text(""),
      ],
    );
  }

}
