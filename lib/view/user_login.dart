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
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  icon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password',
              border: OutlineInputBorder(),
              icon: Icon(Icons.lock_outline)),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
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
