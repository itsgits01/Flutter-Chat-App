import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/pages/forgot_pw_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          _emailController.text.trim(), _passController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                //logo
                Icon(
                  Icons.message_rounded,
                  size: 80,
                ),

                SizedBox(
                  height: 20,
                ),
                //welcome msg
                Text(
                  "Hello there you\'ve been missed!!",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(
                  height: 20,
                ),
                //email textfield
                MyTextField(
                    controller: _emailController,
                    hintText: "Email",
                    obscureText: false),

                SizedBox(
                  height: 20,
                ),
                //password textfield
                MyTextField(
                    controller: _passController,
                    hintText: 'Password',
                    obscureText: true),
                //signin
                SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ForgotPasswordPage();
                        }));
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                MyButton(onTap: signIn, text: "Sign In"),

                SizedBox(
                  height: 10,
                ),
                //not a member text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
