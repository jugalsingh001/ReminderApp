import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = '';
  // String pass = '';
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void showInSnackBar({required String value, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 5.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 270,
                width: 200,
                child: Image.asset(
                  'assets/reminder.png',
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textField(title: 'Username', controller: username, hide: false),
              textField(title: 'Password', controller: password, hide: true),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  if (username.text.trim().isEmpty) {
                    showInSnackBar(
                        value: 'Please input username', context: context);
                  } else if (password.text.trim().isEmpty) {
                    showInSnackBar(
                        value: 'Please input password', context: context);
                  } else {
                    if (username.text.endsWith('@gmail.com')) {
                      user = username.text.replaceAll('@gmail.com', '');
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => HomePage(
                            username: user,
                          ),
                        ),
                      );
                      username.clear();
                      password.clear();
                    } else {
                      showInSnackBar(
                          value: 'Invalid Username', context: context);
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF3739A6), Color(0xFF8B4FE3)]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        username.clear();
                        password.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3739A6), Color(0xFF8B4FE3)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget textField(
    {required String title,
    required TextEditingController controller,
    required bool hide}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      // decoration: BoxDecoration(
      //     color: Colors.white.withOpacity(0.5),
      //     borderRadius: BorderRadius.circular(20)),
      child: StatefulBuilder(builder: (ctx, setState) {
        return TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          obscureText: hide,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            // border: OutlineInputBorder(borderSide: BorderSide()),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            labelText: title,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            hintStyle: const TextStyle(fontSize: 18),
          ),
        );
      }),
    ),
  );
}
