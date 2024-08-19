import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_edit.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            dragDismissible: false,
            key: ValueKey(0),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseFunctions.deleteTask(widget.task.id)
                      .timeout(
                    Duration(microseconds: 0),
                    onTimeout: () =>
                        Provider.of<TasksProvider>(context, listen: false)
                            .getTasks(),
                  )
                      .catchError((error) {
                    Fluttertoast.showToast(
                        msg: "Something went wrong!",
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 5,
                        backgroundColor: AppTheme.red.withOpacity(0.9),
                        textColor: AppTheme.white,
                        fontSize: 16.0);
                    print(error);
                  });
                },
                backgroundColor: AppTheme.red,
                foregroundColor: AppTheme.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onDoubleTap: () async {
              // Navigator.of(context)
              //     .pushNamed(TaskEdit.routeName, arguments: widget.task );
              final updatedTask = await Navigator.of(context).pushNamed(
                TaskEdit.routeName,
                arguments: widget.task,
              ) as TaskModel?;

              // Update the UI if the task was edited
              if (updatedTask != null) {
                setState(() {
                  widget.task.title = updatedTask.title;
                  widget.task.description = updatedTask.description;
                  widget.task.date = updatedTask.date;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.white,
                // borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 8),
                    width: 4,
                    height: 62,
                    color: AppTheme.primraryLight,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: isDone
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppTheme.green),
                      ),
                      Text(
                        widget.task.description,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onDoubleTap: () {
                      isDone = !isDone;
                      setState(() {});
                    },
                    child: isDone
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppTheme.primraryLight,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: AppTheme.white,
                              size: 40,
                            ),
                          )
                        : Text(
                            "Done!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontSize: 25, color: AppTheme.green),
                          ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// class TaskData {
//   String title;
//   String Desc;
//   DateTime date;
//   TaskData({required this.title, required this.Desc, required this.date});
// }
