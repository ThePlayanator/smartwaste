import 'package:flutter/material.dart';
import '../controller/user_controller.dart';

class UserRegisterView extends StatefulWidget {
  const UserRegisterView({Key? key}) : super(key: key);

  @override
  State<UserRegisterView> createState() => _UserRegisterViewState();
}

class _UserRegisterViewState extends State<UserRegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController icController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserPageController _newUserController = UserPageController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New User'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: "Username",
            border: OutlineInputBorder(),
                icon: Icon(Icons.person)),
            controller: usernameController,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: "Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.lock_outline_rounded)),
            controller: passwordController,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: "Fullname",
                border: OutlineInputBorder(),
                icon: Icon(Icons.abc)),
            controller: fullnameController,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: "IC Number",
                border: OutlineInputBorder(),
              icon: Icon(Icons.credit_card)),
            keyboardType: TextInputType.number,
            controller: icController,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: "Phone Number",
                border: OutlineInputBorder(),
              icon: Icon(Icons.phone_android)),
            keyboardType: TextInputType.number,
            controller: phoneNumberController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {

              if (usernameController.text.isEmpty || passwordController.text.isEmpty
              || fullnameController.text.isEmpty || icController.text.isEmpty ||
              phoneNumberController.text.isEmpty)
              {
                setState(() {
                  errorMessage = 'All fields cannot be empty.';
                });
                return;
              }

              // Clear any previous error message
              setState(() {
                errorMessage = '';
              });

              _newUserController.createUser(
                  username: usernameController.text,
                  password: passwordController.text,
                  fullname: fullnameController.text,
                  ic: icController.text,
                  phoneNumber: phoneNumberController.text,
                  id: "",
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration Successful'),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
