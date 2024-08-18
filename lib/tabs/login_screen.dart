import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/register_screen.dart';
import 'package:todo/tabs/login_screen.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          " Login",
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.bgLight,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formkey,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/splash.png",
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DefaultTextFormField(
                    controller: EmailController,
                    hintText: "Email",
                    icon: Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email can't be empty";
                      }
                      if (value.length < 5) {
                        return "Email is wrong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultTextFormField(
                      controller: PasswordController,
                      hintText: "Password",
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password can't be empty";
                        }
                        if (value.length < 6) {
                          return "Password can't be less than 6 characters";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  DefElevatedbutton(
                      label: "Login",
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          print("done");
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text("Don't have an account yet?",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: 16, color: AppTheme.primraryLight)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
