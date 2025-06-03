import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';
import 'package:greenbus_frontend/screens/settings/about.dart';
import 'package:greenbus_frontend/screens/settings/change_password.dart';
import 'package:greenbus_frontend/screens/settings/notifications.dart';
import 'package:greenbus_frontend/screens/settings/profile_edit.dart';
import 'package:greenbus_frontend/screens/settings/support.dart';
import 'package:greenbus_frontend/screens/settings/theme.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final authProvider = Provider.of<Authprovider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          FutureBuilder(
            future: userProvider.getdata(),
            builder: (context, snapshot) {
              String name = "No Name";
              String email = "No Email";

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final data = snapshot.data as Map<String, dynamic>;
                name = data["name"] ?? name;
                email = data["email"] ?? email;
              }

              return ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 240,
                  color: Colors.green.shade400,
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color.fromARGB(255, 46, 125, 50),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 20),
                _buildOption(
                  context,
                  FontAwesomeIcons.userPen,
                  "Edit Profile",
                  EditProfileScreen(),
                ),
                _buildOption(
                  context,
                  FontAwesomeIcons.lock,
                  "Change Password",
                  ChangePasswordScreen(),
                ),
                _buildOption(
                  context,
                  FontAwesomeIcons.bell,
                  "Notifications",
                  NotificationsScreen(),
                ),
                _buildOption(
                  context,
                  FontAwesomeIcons.palette,
                  "App Theme",
                  ThemeScreen(),
                ),
                _buildOption(
                  context,
                  FontAwesomeIcons.circleQuestion,
                  "Help & Support",
                  SupportScreen(),
                ),
                _buildOption(
                  context,
                  FontAwesomeIcons.circleInfo,
                  "About",
                  AboutScreen(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      leading: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      onTap: () async {
                        await authProvider.Logout();
                        Navigator.of(context).pushReplacementNamed("/login");
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    IconData icon,
    String title,
    Widget? screen, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Icon(icon, color: Colors.green.shade700),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
          onTap:
              onTap ??
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen!),
              ),
        ),
      ),
    );
  }
}
