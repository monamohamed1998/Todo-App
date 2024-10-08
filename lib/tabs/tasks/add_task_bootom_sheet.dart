import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBootomSheet extends StatefulWidget {
  const AddTaskBootomSheet({super.key});

  @override
  State<AddTaskBootomSheet> createState() => _AddTaskBootomSheetState();
}

class _AddTaskBootomSheetState extends State<AddTaskBootomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateFormat dateformat = DateFormat("dd/MM/yyyy");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: settingsProvider.isdark ? AppTheme.black : AppTheme.white,
        height: MediaQuery.of(context).size.height * 0.55,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.addnewtask,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: DefaultTextFormField(
                  controller: titlecontroller,
                  hintText: AppLocalizations.of(context)!.addtasktitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: DefaultTextFormField(
                  controller: desccontroller,
                  hintText: AppLocalizations.of(context)!.adddescription,
                  maxlines: 5,
                  // validator: (value) {
                  //   if (value == null || value.trim().isEmpty) {
                  //     return "Description can't be empty";
                  //   }
                  //   return null;
                  // },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.selectdate,
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
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialDate: selecteddate,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
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
                  label: AppLocalizations.of(context)!.submit,
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      addTask();
                      print("____________________________");
                      Navigator.of(context, rootNavigator: true).pop();

                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks(
                              Provider.of<UserProvider>(context, listen: false)
                                  .currentUser!
                                  .id);
                      // setState(() {});
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userid =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseFunctions.addToFireStore(
            TaskModel(
              title: titlecontroller.text,
              description: desccontroller.text,
              date: selecteddate,
            ),
            userid)
        .then((value) {
      Fluttertoast.showToast(
          msg: "Task Added Successfully",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.primraryLight.withOpacity(0.9),
          textColor: AppTheme.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Something went wrong!!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red.withOpacity(0.9),
          textColor: AppTheme.white,
          fontSize: 16.0);
      print(error);
    });
  }
}
