import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskEdit extends StatefulWidget {
  static const String routeName = "task_edit";

  const TaskEdit({super.key});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController desccontroller = TextEditingController();

  DateTime selecteddate = DateTime.now();

  DateFormat dateformat = DateFormat("dd/MM/yyyy");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool saveDate = false;

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (saveDate) {
      final newdate = Provider.of<TasksProvider>(context).selecteddate;
      tasksProvider.changeDate(newdate);
      saveDate = true;
    }
    final TaskModel task =
        ModalRoute.of(context)?.settings.arguments as TaskModel;

    titlecontroller.text = task.title;
    desccontroller.text = task.description;
    selecteddate = task.date;
    return Scaffold(
      body: Stack(
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
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: AppTheme.white,
                ),
                Text(AppLocalizations.of(context)!.todo,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppTheme.white, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.11,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Color.fromARGB(204, 199, 245, 245),
                    borderRadius: BorderRadius.circular(15)),
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppLocalizations.of(context)!.edittask,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Spacer(),
                      Expanded(
                        child: DefaultTextFormField(
                          controller: titlecontroller,
                          hintText: AppLocalizations.of(context)!.edittasktitle,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Title can't be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            task.title = titlecontroller.text;
                          },
                        ),
                      ),
                      Expanded(
                        child: DefaultTextFormField(
                          controller: desccontroller,
                          hintText:
                              AppLocalizations.of(context)!.edittaskdetails,
                          maxlines: 5,
                          onChanged: (value) {
                            task.description = desccontroller.text;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(AppLocalizations.of(context)!.selectdate,
                          style: Theme.of(context).textTheme.headlineSmall),
                      InkWell(
                          onTap: () async {
                            DateTime? datetime = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              initialDate: selecteddate,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            // __________________________________________
                            selecteddate = datetime!;
                            setState(() {});
                          },
                          child: Text(
                            dateformat.format(
                              selecteddate,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      DefElevatedbutton(
                          label: AppLocalizations.of(context)!.done,
                          onpressed: () {
                            if (formkey.currentState!.validate()) {
                              task.title = titlecontroller.text;
                              task.description = desccontroller.text;
                              task.date = selecteddate;

                              //  Create the updatedTask object with new values
                              TaskModel updatedTask = TaskModel(
                                id: task.id,
                                title: titlecontroller.text,
                                description: desccontroller.text,
                                date: selecteddate,
                              );
                              final userid = Provider.of<UserProvider>(context,
                                      listen: false)
                                  .currentUser!
                                  .id;
                              //  save the updated task
                              FirebaseFunctions.updateTask(updatedTask, userid)
                                  .then((_) {});
                              Navigator.of(context).pop(task);
                            }
                          }),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

//  PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.17),
//         child: AppBar(
//           title: Text(
//             "Edit Task",
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall
//                 ?.copyWith(fontSize: 25, color: AppTheme.white),
//           ),
//           centerTitle: true,
//           backgroundColor: AppTheme.primraryLight,
//         ),
//       ),
