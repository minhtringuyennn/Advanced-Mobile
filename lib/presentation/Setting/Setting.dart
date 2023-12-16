import 'package:advanced_mobile/presentation/Profile/Profile.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../main.dart';
import '../Courses/Courses.dart';
import '../History/History.dart';
import '../Home/Home.dart';
import '../Schedule/Schedule.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage = 'Automatic';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 125,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue, border: null),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Menu",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Tutors',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.school,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Courses',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Courses()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Schedule',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Schedule()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'History',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text('Logout',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              onTap: () {
                var authProvider = context.watch<AuthProvider>();
                authProvider.clearUserInfo();
              },
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0), // Define the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Color and opacity of the shadow
                spreadRadius: 5, // Spread radius of the shadow
                blurRadius: 7, // Blur radius of the shadow
                offset: const Offset(0, 3), // Offset of the shadow
              ),
            ],
          ),
          child: AppBar(
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.black,
                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        size: 45,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 7),
                      Text(
                        "LetTutor",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: Colors.blue,
              // userName: userProvider.userData?.user!.name ?? "Anonymous",
              userName: "Nguyễn Minh Trí" ?? "Anonymous",

              // userProfilePic: NetworkImage(userProvider.userData?.user!.avatar ?? "https://yt3.googleusercontent.com/mm2-5anuZ6ghmK2zL6QM7wciD6kuupOfOagiAh5vZE1hx9tRhKEXTAExZUUY4PVq2RSw9jBpBQ=s900-c-k-c0x00ffffff-no-rj"
              //        ,scale:1),
              userProfilePic: const NetworkImage(
                  "https://yt3.googleusercontent.com/mm2-5anuZ6ghmK2zL6QM7wciD6kuupOfOagiAh5vZE1hx9tRhKEXTAExZUUY4PVq2RSw9jBpBQ=s900-c-k-c0x00ffffff-no-rj",
                  scale: 1),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.blue[600],
                ),
                title: "Profile",
                subtitle: "Tap to change your profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: "App Settings",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.grey,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                SettingsItem(
                    onTap: () {},
                    icons: Icons.language,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.grey,
                    ),
                    title: 'Language',
                    subtitle: selectedLanguage ?? 'Automatic',
                    trailing: Container(
                      width: 120, // Set width to match parent
                      height: 42.0, // Set height to match TextInput
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButton<String>(
                          underline: Container(),
                          isDense: true,
                          isExpanded: true,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue!;
                            });
                          },
                          items: <String>['English', 'Vietnamese']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.wallet,
                  iconStyle: IconStyle(),
                  title: 'My Wallet',
                  subtitle: "Manage your wallet",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.co_present,
                  iconStyle: IconStyle(),
                  title: 'Become a tutor',
                  subtitle: "How to become a tutor",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Overview",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about LetTutor App",
                ),
                SettingsItem(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Log out successful!.'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    var authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    authProvider.clearUserInfo();
                  },
                  icons: Icons.logout,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.red,
                  ),
                  title: 'Logout',
                  subtitle: "Log out LetTutor app",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
