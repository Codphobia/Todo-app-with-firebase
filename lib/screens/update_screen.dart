import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/models/task_model.dart';

class UpdateScreen extends StatefulWidget {
  TaskModel taskModel;

  UpdateScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var nameEditingController = TextEditingController();
  var titleEditingController = TextEditingController();

  @override
  void initState() {
    nameEditingController.text = widget.taskModel.taskName;
    titleEditingController.text = widget.taskModel.taskTile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 74, 96, 17),
      appBar: AppBar(
        title: const Text(
          'Update The Task Now',
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
                children: [ TextField(
                  controller: titleEditingController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'update the task',
                      hintStyle: TextStyle(
                        letterSpacing: 15,
                      )),
                ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextField(
                    controller: nameEditingController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        hintText: 'update the title',
                        hintStyle: const TextStyle(
                          letterSpacing: 15,
                        )),
                  ),
                    SizedBox(
                    height: 7,

                  ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: const Color.fromRGBO(214, 237, 23, 1),
                        shadowColor: Colors.grey,
                      ),
                      onPressed: () async {
                        String taskName = nameEditingController.text.trim();
                        String taskTitle = titleEditingController.text.trim();
                        if (taskName.isEmpty || taskTitle.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'please provide both text',
                            backgroundColor:
                                const Color.fromRGBO(214, 237, 23, 1),
                          );
                          return;
                        }
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          DatabaseReference reaf = FirebaseDatabase.instance
                              .reference()
                              .child('task')
                              .child(user.uid)
                              .child(widget.taskModel.taskId);

                          await reaf.update({
                            'taskName': taskName,
                            'taskTile': taskTitle,
                          });
                        }

                        Navigator.of(context).pop();
                        //firebase
                      },
                      child: const Text('Update')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
