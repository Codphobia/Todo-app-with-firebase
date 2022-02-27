import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:todo/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'list_task_screen.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 74, 96, 17),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.13),
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 65,
                      left: 25,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: const Color.fromRGBO(214, 237, 23, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 85,
                      left: 20,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 79,
                      left: 40,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 40,
                      child: Text('Login',
                          style: GoogleFonts.alike(
                            textStyle: const TextStyle(
                              color: Color.fromRGBO(214, 237, 23, 1),
                              fontSize: 40,
                            ),
                          )),
                    ),

                    Positioned(
                      top: 136,
                      left: 127,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: const Color.fromRGBO(214, 237, 23, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 133,
                      left: 148,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 153,
                      left: 140,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView
                (scrollDirection: Axis.vertical,
                child: Container(

                    width: double.infinity,
                    height: 500,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(214, 237, 23, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailTextEditingController,
                          style: const TextStyle(
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          cursorColor: const Color.fromRGBO(214, 237, 23, 1),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              letterSpacing: 2,
                              color: Color.fromRGBO(96, 96, 96, 10),
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromRGBO(96, 96, 96, 10),
                                size: 20),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(

                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          cursorColor: const Color.fromRGBO(214, 237, 23, 1),
                          controller: passwordTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              letterSpacing: 2,
                              color: Color.fromRGBO(96, 96, 96, 10),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromRGBO(96, 96, 96, 10),
                                size: 20),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color.fromRGBO(96, 96, 96, 10),
                                  size: 20),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.pink,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () async {
                              if (emailTextEditingController.text
                                      .toString()
                                      .trim()
                                      .isEmpty ||
                                  passwordTextEditingController.text
                                      .toString()
                                      .trim()
                                      .isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'please provide email and  password',
                                    backgroundColor: Colors.pinkAccent);
                              }
                              ProgressDialog progressDialog = ProgressDialog(
                                context,
                                title: const Text('Signing..'),
                                message: const Text('Please waiting '),
                              );
                              progressDialog.show();

//firebase
                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: emailTextEditingController.text,
                                        password:
                                            passwordTextEditingController.text);
                                if (userCredential != null) {
                                  progressDialog.dismiss();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        const ListTaskScreen(),
                                  ));
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  Fluttertoast.showToast(
                                      msg: 'user not found',
                                      backgroundColor: Colors.purple);
                                } else if (e.code == 'wrong-password') {
                                  Fluttertoast.showToast(
                                      msg: 'wrong password',
                                      backgroundColor: Colors.purple);
                                }
                              } catch (e) {
                                progressDialog.dismiss();
                                Fluttertoast.showToast(
                                    msg: 'something went wrong',
                                    backgroundColor: Colors.purple);
                              }
                            },
                            child: const Text(
                              'login',
                              style: TextStyle(
                                color: Color.fromRGBO(96, 96, 96, 10),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Register not yet..?',
                              style: TextStyle(
                                color: Color.fromRGBO(96, 96, 96, 10),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ));
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color.fromRGBO(96, 96, 96, 10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
