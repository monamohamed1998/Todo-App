import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home_page.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/def_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final bool isObsecure = false;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: settingsProvider.isdark
            ? AppTheme.primrarydark
            : Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.login,
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formkey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/splash.png",
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultTextFormField(
                    controller: EmailController,
                    hintText: AppLocalizations.of(context)!.email,
                    icon: const Icon(Icons.email),
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
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultTextFormField(
                      controller: PasswordController,
                      hintText: AppLocalizations.of(context)!.password,
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
                  const SizedBox(
                    height: 30,
                  ),
                  DefElevatedbutton(
                      label: AppLocalizations.of(context)!.login,
                      onpressed: () {
                        login(context);
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                          AppLocalizations.of(context)!.donthaveanaccount,
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

  void login(BuildContext context) {
    if (formkey.currentState!.validate()) {
      FirebaseFunctions.login(
              email: EmailController.text, password: PasswordController.text)
          .then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }).catchError((error) {
        String? msg;
        if (error is FirebaseAuthException) {
          msg = error.message;
        }
        Fluttertoast.showToast(
            msg: msg ?? "Something went wrong!!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.red.withOpacity(0.9),
            textColor: AppTheme.white,
            fontSize: 16.0);
      });
    }
  }
}
