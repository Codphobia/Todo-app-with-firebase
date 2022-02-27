import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var titleEditingController = TextEditingController();
  var nameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(66, 74, 96, 17),
        appBar: AppBar(
          title: const Text(
            'Add New Task Now',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: titleEditingController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Add title',
                        hintStyle: TextStyle(
                          letterSpacing: 15,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextField(
                      controller: nameEditingController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Add new Task',
                        hintStyle: TextStyle(
                          letterSpacing: 15,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: const Color.fromRGBO(214, 237, 23, 1),
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () async {
                          String taskName =
                              nameEditingController.text.toString().trim();
                          String taskTitle=titleEditingController.text.trim();
                          if (taskName.isEmpty || taskTitle.isEmpty) {
                            Fluttertoast.showToast(
                              msg: 'please provide text and title',
                              backgroundColor:
                                  const Color.fromRGBO(214, 237, 23, 1),
                            );
                            return;
                          }

                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            String uid = user.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;
                            DatabaseReference reference = FirebaseDatabase
                                .instance
                                .reference()
                                .child('task')
                                .child(uid);

                            String taskId = reference.push().key;
                            await reference.child(taskId).set({
                              'dt': dt,
                              'taskName': taskName,
                              'taskId': taskId,
                              'taskTile': taskTitle
                            });
                            Navigator.of(context).pop();
                          }

                          //firebase
                        },
                        child: const Text('Save')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
