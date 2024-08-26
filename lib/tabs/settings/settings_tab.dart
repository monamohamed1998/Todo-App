import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingTab extends StatelessWidget {
  static const String routeName = "/setting_tab";

  const SettingTab({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.darkmode,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Switch(
                    activeTrackColor: AppTheme.primraryLight,
                    inactiveTrackColor: Colors.grey,
                    value: settingsProvider.isdark,
                    onChanged: (isdark) {
                      settingsProvider.changeThemeMode(
                          isdark ? ThemeMode.dark : ThemeMode.light);
                    })
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      dropdownColor: settingsProvider.isdark
                          ? AppTheme.grey
                          : AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      style: Theme.of(context).textTheme.labelSmall,
                      value: settingsProvider.language,
                      items: [
                        DropdownMenuItem(
                            value: 'en',
                            child: Text("English",
                                style: Theme.of(context).textTheme.bodyLarge)),
                        DropdownMenuItem(
                            value: 'ar',
                            child: Text("Arabic",
                                style: Theme.of(context).textTheme.bodyLarge))
                      ],
                      onChanged: (selectedvalue) {
                        if (selectedvalue == null) return;
                        settingsProvider.changeLanguage(selectedvalue);
                      }),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 22),
                ),
                IconButton(
                    onPressed: () {
                      FirebaseFunctions.logout();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                      Provider.of<TasksProvider>(context, listen: false)
                          .tasks
                          .clear();
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
