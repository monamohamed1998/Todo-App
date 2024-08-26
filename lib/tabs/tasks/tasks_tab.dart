import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    if (shouldGetTasks) {
      final userid = Provider.of<UserProvider>(context).currentUser!.id;
      tasksProvider.getTasks(userid);
      shouldGetTasks = false;
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: const BoxDecoration(
                color: AppTheme.primraryLight,
              ),
            ),
            PositionedDirectional(
              top: 30,
              start: 10,
              child: Text(AppLocalizations.of(context)!.todo,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppTheme.white, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              child: EasyInfiniteDateTimeLine(
                showTimelineHeader: false,
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                focusDate: tasksProvider.selecteddate,
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateChange: (date) {
                  tasksProvider.changeDate(date);
                  tasksProvider.getTasks(
                      Provider.of<UserProvider>(context, listen: false)
                          .currentUser!
                          .id);
                },
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                    height: 100,
                    width: 50,
                    todayStyle: const DayStyle(
                      monthStrStyle: TextStyle(color: Colors.transparent),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      monthStrStyle: const TextStyle(color: Colors.transparent),
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    activeDayStyle: DayStyle(
                      monthStrStyle: const TextStyle(color: Colors.transparent),
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(20)),
                      dayStrStyle: const TextStyle(
                          color: AppTheme.primraryLight,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      dayNumStyle: const TextStyle(
                          color: AppTheme.primraryLight,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemBuilder: (_, index) => TaskItem(
            task: tasksProvider.tasks[index],
          ),
          itemCount: tasksProvider.tasks.length,
        )),
      ],
      // color: Colors.blue,
    );
  }
}
