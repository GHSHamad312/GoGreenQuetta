import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';
import 'package:greenbus_frontend/screens/auth/loginscreen.dart';
import 'package:greenbus_frontend/screens/settings/about.dart';
import 'package:greenbus_frontend/screens/settings/change_password.dart';
import 'package:greenbus_frontend/screens/settings/notifications.dart';
import 'package:greenbus_frontend/screens/settings/profile_edit.dart';
import 'package:greenbus_frontend/screens/settings/support.dart';
import 'package:greenbus_frontend/screens/settings/themescreen.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    _userFuture = userProvider.getdata();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authprovider>(context, listen: false);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: _userFuture,
            builder: (context, snapshot) {
              String name = "No Name";
              String email = "No Email";

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final data = snapshot.data!;
                name = data["name"] ?? name;
                email = data["email"] ?? email;
              }

              return ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 240,
                  color: colorScheme.primary,
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: colorScheme.secondary,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              email,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 15,
                                color: colorScheme.onPrimary.withOpacity(0.7),
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
                const SizedBox(height: 20),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      leading: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: colorScheme.error,
                      ),
                      title: Text(
                        "Logout",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.error,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                      onTap: () async {
                        await authProvider.logout;
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
    Widget screen, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          leading: Icon(icon, color: colorScheme.primary),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
          onTap:
              onTap ??
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen),
              ),
        ),
      ),
    );
  }
}
