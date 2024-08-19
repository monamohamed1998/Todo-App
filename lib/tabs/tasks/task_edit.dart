import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/task_item.dart';

class TaskEdit extends StatelessWidget {
  static const String routeName = "task_edit";

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateFormat dateformat = DateFormat("dd/MM/yyyy");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
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
                  icon: Icon(Icons.arrow_back),
                  color: AppTheme.white,
                ),
                Text("TODO List",
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppTheme.white,
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
                        "Edit Task",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: DefaultTextFormField(
                          controller: titlecontroller,
                          hintText: 'Add Task Title',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Title can't be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        child: DefaultTextFormField(
                          controller: desccontroller,
                          hintText: ' Task Details',
                          maxlines: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Selected Date",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 20),
                      ),
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
                            if (datetime != null) {
                              selecteddate = datetime;
                              // setState(() {});
                            }
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
                          label: "Submit",
                          onpressed: () {
                            if (formkey.currentState!.validate()) {
                              task.title = titlecontroller.text;
                              task.description = desccontroller.text;
                              task.date = selecteddate;

                              // Pop the page and return to the previous screen
                              Navigator.of(context).pop(task);
                            }
                          }),
                      Spacer(),
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
