import 'package:flutter/material.dart';
import 'package:smartwaste/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Account Settings'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Handle account settings
              print('Account Settings tapped');
            },
          ),
          ListTile(
            title: Text('Notification Settings'),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Handle notification settings
              print('Notification Settings tapped');
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            leading: Icon(Icons.lock),
            onTap: () {
              // Handle privacy settings
              print('Privacy Settings tapped');
            },
          ),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.info),
            onTap: () {
              // Handle about page
              print('About tapped');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              // Handle log out
              print('Log Out tapped');
              //Navigator.popUntil(context, ModalRoute.withName('/login_page'));
            },
          ),
        ],
      ),
    );
  }
}
