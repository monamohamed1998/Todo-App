import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class AddTaskBootomSheet extends StatefulWidget {
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
    return Container(
      // height: MediaQuery.of(context).size.height * 0.55,
      padding: EdgeInsets.all(20),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Text(
              "Add New Task",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
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
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: DefaultTextFormField(
                controller: desccontroller,
                hintText: 'Add Description',
                maxlines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description can't be empty";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Select Date",
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
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: selecteddate,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (datetime != null) {
                    selecteddate = datetime;
                    setState(() {});
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
            SizedBox(
              height: 20,
            ),
            DefElevatedbutton(
                label: "Submit",
                onpressed: () {
                  if (formkey.currentState!.validate()) {
                    print(formkey.currentState!.validate());
                  }
                  addTask();
                }),
          ],
        ),
      ),
    );
  }

  void addTask() {
    print("Added");
  }
}
