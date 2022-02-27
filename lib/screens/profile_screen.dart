import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:todo/models/users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var fullNameTextEditingController = TextEditingController();
  User? user;
  UserModel? userModel;
  DatabaseReference? userRefer;
  File? pickedImage;
  bool showlocalImage = false;

  getProfile() async {
    DataSnapshot snapshot = await userRefer!.once();
    userModel = UserModel.fromMap(Map<String, dynamic>.from(snapshot.value));
    fullNameTextEditingController.text = userModel!.fullName;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userRefer =
          FirebaseDatabase.instance.reference().child('users').child(user.uid);
      getProfile();
    }
  }

  getImageFromGalleryOrCamera(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file == null) return;
    pickedImage = File(file.path);
    showlocalImage = true;
    setState(() {});

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text(
        'Uploading..!!',
        textAlign: TextAlign.center,
      ),
      message: const Text('Please wait'),
    );
    progressDialog.show();
    try {
      var fileName = userModel!.email + '.jpg';
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('my_profile')
          .child(fileName)
          .putFile(pickedImage!);
      TaskSnapshot snapshot = await uploadTask;
      String getImageUrl = await snapshot.ref.getDownloadURL();

      userRefer!.child(userModel!.userUid);
      await userRefer!.update({
        'profile': getImageUrl,
      });
      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(66, 74, 96, 17),
      body: SafeArea(
        child: userModel == null
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 340,
                      child: Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                        ),
                        ShapeOfView(
                          elevation: 4,
                          shape: ArcShape(
                            direction: ArcDirection.Outside,
                            height: 15,
                            position: ArcPosition.Bottom,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://i.pinimg.com/originals/4b/da/a2/4bdaa23b06619736e31ffa9aef065b5f.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.indigoAccent,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60))),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: showlocalImage == false
                                    ? NetworkImage(
                                        userModel!.profileImage == ''
                                            ? 'https://previews.123rf.com/images/apoev/apoev1903/'
                                                'apoev190300009/124806570-%E7%81%B0%E8%89%B2%E3%81%AE%'
                                                'E8%83%8C%E6%99%AF%E3%81%ABt%E3%82%B7%E3%83%A3%E3%83%84%'
                                                'E3%82%92%E7%9D%80%E3%81%9F%E4%BA%BA%E7%81%B0%E8%89%B2%E3'
                                                '%81%AE%E5%86%99%E7%9C%9F%E3%83%97%E3%83%AC%E3%83%BC%E3%8'
                                                '2%B9%E3%83%9B%E3%83%AB%E3%83%80%E3%83%BC%E3%83%9E%E3%83%B3.jpg'
                                            : userModel!.profileImage,
                                      )
                                    : FileImage(pickedImage!)
                                        as ImageProvider,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Color.fromRGBO(66, 74, 96, 17),
                                          context: context,
                                          builder: (ctx) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    leading: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    title: const Text(
                                                        'With Camera'),
                                                    onTap: () {
                                                      getImageFromGalleryOrCamera(
                                                          ImageSource.camera);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.storage),
                                                    ),
                                                    title: const Text(
                                                        ' From Gallery'),
                                                    onTap: () {
                                                      getImageFromGalleryOrCamera(
                                                          ImageSource
                                                              .gallery);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Text(
                      'MY PROFILE',
                      style: GoogleFonts.alike(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Text('1)'),
                      title: const Text('Full Name'),
                      subtitle: Text(userModel!.fullName),
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Sure you can Edit..',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.alike(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                actions: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  TextField(
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    controller:
                                    fullNameTextEditingController,
                                    cursorColor: Colors.white,
                                    decoration:
                                    const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      focusedBorder:
                                      UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(
                                            color: Color.fromRGBO(
                                                96, 96, 96, 10),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton
                                          .styleFrom(
                                        primary:
                                        Colors.pinkAccent,
                                        shadowColor:
                                        Colors.grey,
                                      ),
                                      onPressed: () async {
                                        String fullName =
                                        fullNameTextEditingController
                                            .text
                                            .trim();

                                        userRefer!.child(
                                            userModel!.userUid);
                                        await userRefer!
                                            .update({
                                          'Fullname': fullName,
                                        });

                                        Navigator.of(context)
                                            .pop();
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                    ListTile(
                      leading: const Text('2)'),
                      title: const Text('Email'),
                      subtitle: Text(userModel!.email),
                    ),
                    ListTile(
                      leading: const Text('3)'),
                      title: const Text('Member Joined'),
                      subtitle: Text(
                        humanReadableTime(userModel!.dt),
                      ),
                    ),

                  ],
                ),
              ),
      ),
    );
  }

  String humanReadableTime(int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);
    return DateFormat('dd MM yyyy').format(dateTime);
  }
}
