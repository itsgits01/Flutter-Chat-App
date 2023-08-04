import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cnfrmPassController = TextEditingController();

  //signup method

  void signUp() async {
    if (_passController.text.trim() != _cnfrmPassController.text.trim()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signupwithEmailAndPassword(
          _emailController.text.trim(), _passController.text.trim());
      addUserDetails(_usernameController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }

  Future addUserDetails(String userName) async {
    await FirebaseFirestore.instance.collection('names').add({
      'user name':userName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
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
                    "Welcome to best Chat App, Start here!!",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  MyTextField(controller: _usernameController, hintText: 'User Name', obscureText: false),

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

                  SizedBox(
                    height: 20,
                  ),
                  //password textfield
                  MyTextField(
                      controller: _cnfrmPassController,
                      hintText: 'Confirm Password',
                      obscureText: true),

                  //signin

                  SizedBox(
                    height: 20,
                  ),

                  MyButton(onTap: signUp, text: "Sign Up"),

                  SizedBox(
                    height: 10,
                  ),
                  //not a member text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Login now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
