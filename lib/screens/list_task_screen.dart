import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/screens/update_screen.dart';

import '../models/task_model.dart';
import 'add_task_screen.dart';
import 'login_screen.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({Key? key}) : super(key: key);

  @override
  _ListTaskScreenState createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  User? user;
  DatabaseReference? referenc;

  @override
  void initState() {
    // TODO: implement initState

    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      referenc =
          FirebaseDatabase.instance.reference().child('task').child(user!.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 74, 96, 17),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 8,
              backgroundColor: Colors.transparent,
              pinned: true,
              floating: true,
              actions: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const ProfilePage();
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.blueGrey,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,

                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: const Color.fromRGBO(66, 74, 96, 17),
                              content: Text(
                                'Are You sure want to Logout..?',
                                style: GoogleFonts.alike(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Confirmation..!',
                                style: GoogleFonts.alike(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const loginPage(),
                                          ));
                                        },
                                        child: Text(
                                          'Yes',
                                          style: GoogleFonts.alike(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: GoogleFonts.alike(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.blueGrey,
                        )),
                  ],
                ),
              ],
              centerTitle: true,
              expandedHeight: 250.0,
              flexibleSpace: Container(
                padding: const EdgeInsets.all(10),
                height: 400,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/4b/da/a2/4bdaa23b06619736e31ffa9aef065b5f.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    ' Add List Task ',
                    style: GoogleFonts.alike(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                StreamBuilder(
                  stream: referenc != null ? referenc!.onValue : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && !snapshot.hasError) {
                      var event = snapshot.data as Event;
                      var snapshot2 = event.snapshot.value;
                      if (snapshot2 == null) {
                        return const Center(
                          child: Text('Task Not Add yet.'),
                        );
                      }
                      Map<String, dynamic> map =
                          Map<String, dynamic>.from(snapshot2);
                      List<TaskModel> tasks = [];
                      for (var taskMap in map.values) {
                        TaskModel taskModel = TaskModel.fromMap(
                          Map<String, dynamic>.from(taskMap),
                        );
                        tasks.add(taskModel);
                      }
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          TaskModel taskModel = tasks[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              actions: [
                                IconSlideAction(
                                  color: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  caption: 'delete',
                                  icon: Icons.delete,
                                  onTap: () async {
                                    if (referenc != null) {
                                      await referenc!
                                          .child(taskModel.taskId)
                                          .remove();
                                    }
                                  },
                                ),
                                IconSlideAction(
                                  color: const Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  caption: 'Edit',
                                  icon: Icons.edit,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(taskModel: taskModel),
                                    ));
                                  },
                                ),
                              ],
                              child: ListTile(
                                title: Text(taskModel.taskTile),
                                subtitle: Text(taskModel.taskName),
                                trailing: Text(
                                  humanReadableTime(taskModel.dt),
                                ),
                              ),
                              actionExtentRatio: 1 / 5,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.white,
                          height: 1.5,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTaskScreen(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(214, 237, 23, 1),
        ),
      ),
    );
  }

  String humanReadableTime(int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);
    return DateFormat('dd MM yyyy').format(dateTime);
  }
}
