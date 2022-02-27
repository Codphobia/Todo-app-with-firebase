import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'list_task_screen.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var fullNameTextEditingController = TextEditingController();
  var conformTextEditingController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;

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


                width: double.infinity,
                height: 200,
                child: Stack(children: [
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
                    child: Text('Sign up',
                        style: GoogleFonts.alike(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(214, 237, 23, 1),
                            fontSize: 40,
                          ),
                        )),
                  ),

                  Positioned(
                    top: 142,
                    left: 158,
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
                    top: 149,
                    left: 175,
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
                    top: 160,
                    left: 160,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.red,
                      ),
                    ),
                  ),

                ]),
              ),
              Container(

                width: double.infinity,
height: MediaQuery.of(context).size.height,

                decoration: const BoxDecoration(
                  color: Color.fromRGBO(214, 237, 23, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(96, 96, 96, 10),
                        ),
                        controller: fullNameTextEditingController,
                        textAlign: TextAlign.justify,
                        cursorColor: const Color.fromRGBO(96, 96, 96, 10),
                        decoration: const InputDecoration(
                          hintText: ' Full name',
                          hintStyle: TextStyle(
                            letterSpacing: 2,
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(96, 96, 96, 10),
                            size: 20,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(96, 96, 96, 10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextEditingController,
                        cursorColor: const Color.fromRGBO(96, 96, 96, 10),
                        style: const TextStyle(
                          color: Color.fromRGBO(96, 96, 96, 10),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            letterSpacing: 2,
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          prefixIcon: Icon(Icons.email,
                              color: Color.fromRGBO(96, 96, 96, 10), size: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(96, 96, 96, 10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextField(
                        obscureText: _obscureText,
                        cursorColor: const Color.fromRGBO(96, 96, 96, 10),
                        controller: passwordTextEditingController,
                        style: const TextStyle(
                          color: Color.fromRGBO(96, 96, 96, 10),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            letterSpacing: 2,
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          prefixIcon: const Icon(Icons.lock,
                              color: Color.fromRGBO(96, 96, 96, 10), size: 20),
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
                                color: Color.fromRGBO(96, 96, 96, 10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextField(
                        obscureText: _obscureText2,
                        keyboardType: TextInputType.text,
                        cursorColor: const Color.fromRGBO(96, 96, 96, 10),
                        controller: conformTextEditingController,
                        style: const TextStyle(
                          color: Color.fromRGBO(96, 96, 96, 10),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Confirm',
                          hintStyle: const TextStyle(
                            letterSpacing: 2,
                            color: Color.fromRGBO(96, 96, 96, 10),
                          ),
                          prefixIcon: const Icon(Icons.lock,
                              color: Color.fromRGBO(96, 96, 96, 10), size: 20),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(
                                    () {
                                  _obscureText2 = !_obscureText2;
                                },
                              );
                            },
                            child: Icon(
                                _obscureText2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromRGBO(96, 96, 96, 10),
                                size: 20),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(96, 96, 96, 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: const Color.fromRGBO(96, 96, 96, 10),
                            shadowColor: Colors.grey,
                          ),
                          onPressed: () async {
                            if (fullNameTextEditingController.text.toString().trim().isEmpty ||
                                emailTextEditingController.text
                                    .toString()
                                    .trim()
                                    .isEmpty ||
                                passwordTextEditingController.text
                                    .toString()
                                    .trim()
                                    .isEmpty ||
                                conformTextEditingController.text
                                    .toString()
                                    .trim()
                                    .isEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                  'please provide email and  password and other',
                                  backgroundColor: Colors.pinkAccent);
                            }

                            if (passwordTextEditingController.text !=
                                conformTextEditingController.text) {
                              Fluttertoast.showToast(
                                  msg: "password doesn't match ",
                                  backgroundColor: Colors.pinkAccent);
                            }
                            if (passwordTextEditingController.text.length < 6) {
                              Fluttertoast.showToast(
                                  msg: "password length less than 6 ",
                                  backgroundColor: Colors.pinkAccent);
                            }

                            ProgressDialog progressDialog = ProgressDialog(
                              context,
                              title: const Text('Signing up'),
                              message: const Text('Please waiting '),
                            );
                            progressDialog.show();
                            //firebase
                            try {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              UserCredential userCredential =
                              await auth.createUserWithEmailAndPassword(
                                  email: emailTextEditingController.text,
                                  password:
                                  passwordTextEditingController.text);
                              if (userCredential != null) {
                                String name =
                                    fullNameTextEditingController.text;
                                String email = emailTextEditingController.text;
                                String password =
                                    passwordTextEditingController.text;
                                // firebase datastore realtime
                                DatabaseReference ref = FirebaseDatabase
                                    .instance
                                    .reference()
                                    .child('users');
                                String uid = userCredential.user!.uid;
                                int dt = DateTime.now().millisecondsSinceEpoch;
                                await ref.child(uid).set({
                                  'Fullname': name,
                                  'email': email,
                                  'password': password,
                                  'uid': uid,
                                  'dt': dt,
                                  'profile': '',
                                });
                                Fluttertoast.showToast(
                                    msg: "success ",
                                    backgroundColor: Colors.pinkAccent);
                                await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return const ListTaskScreen();
                                    },
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "failed ",
                                    backgroundColor: Colors.pinkAccent);
                              }
                              progressDialog.dismiss();
                            } on FirebaseAuthException catch (e) {
                              progressDialog.dismiss();
                              if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(
                                    msg: "email is already used",
                                    backgroundColor: Colors.pinkAccent);
                              } else if (e.code == 'weak-password') {
                                Fluttertoast.showToast(
                                    msg: "password is weak ",
                                    backgroundColor: Colors.pinkAccent);
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "something went wrong ",
                                  backgroundColor: Colors.pinkAccent);
                              progressDialog.dismiss();
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color.fromRGBO(96, 96, 96, 10),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have you Already Register..?',
                            style: TextStyle(
                              color: Color.fromRGBO(96, 96, 96, 10),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color.fromRGBO(96, 96, 96, 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
