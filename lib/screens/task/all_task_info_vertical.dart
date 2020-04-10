import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task/all_task.dart';
import 'package:tasks/screens/task/task_tile_vertical.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/shared/loading.dart';

class AllTaskInfoVertical extends StatefulWidget {
  @override
  _AllTaskInfoVerticalState createState() => _AllTaskInfoVerticalState();
}

class _AllTaskInfoVerticalState extends State<AllTaskInfoVertical> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    int tasksCount = tasks.length;

    return tasksCount != 0
        ? Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0 ),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTileVertical(task: tasks[index]);
              },
            ),
        )
        : Loading();
  }
}
