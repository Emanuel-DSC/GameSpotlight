import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/view/widgets/settings/user_email_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../data/auth/auth_service.dart';
import '../../pages/auth/forget_password_page.dart';
import '../buttons/settings_button.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.user,
  });

  final String user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          color: kSearchBarColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReturnEmail(user: user),
              Divider(
                color: kCardColor,
                height: 35,
                thickness: 1.2,
              ),
              SettingsButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage()));
                },
                color: Colors.grey,
                text: 'Change password',
                icon: EvaIcons.editOutline,
              ),
              Divider(
                color: kCardColor,
                height: 35,
                thickness: 1.2,
              ),
              SettingsButton(
                color: Colors.red,
                text: 'Logout',
                icon: EvaIcons.logOutOutline,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kSearchBarColor,
                        title: const Text(
                          "Log out?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        content: const Text(
                          "Are you sure you want to log out?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              AuthenticationRepository().logout(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Log out",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
