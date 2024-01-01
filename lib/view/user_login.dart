import 'package:flutter/material.dart';
import 'package:smartwaste/view/homepage.dart';
import 'package:smartwaste/view/user_register.dart';
import '../controller/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserPageController _loginController = UserPageController();

  String errorMessage = '';
  String loginId='';
  bool loginStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 10),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Validate username and password
                if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                  setState(() {
                    errorMessage = 'Username and password cannot be empty.';
                  });
                  return;
                }

                // Clear any previous error message
                setState(() {
                  errorMessage = '';
                });

                // Attempt to log in
                loginStatus = await _loginController.loginUser(
                  username: usernameController.text,
                  password: passwordController.text,
                );

                if (loginStatus == true)
                  {
                    loginId = await _loginController.getUserLoginId(
                        username: usernameController.text,
                        password: passwordController.text);

                    if (loginId.length==6)
                      {
                        // Navigate to HomePage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>HomePage(loginId: loginId)),
                        );
                      } else {

                    }
                  } else {
                  setState(() {
                    errorMessage = 'Login Failed';
                  });
                }
              },
              child: Text('Login'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegisterView()));
              },
              child: Text(
                "Don't have an account? Register here.",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
