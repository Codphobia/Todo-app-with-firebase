class UserModel {
  late String userUid;
  late String fullName;
  late String email;
  late String profileImage;
  late int dt;

  UserModel({
    required this.userUid,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.dt,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    userUid = map['uid'];
    fullName = map['Fullname'];
    email = map['email'];
    profileImage = map['profile'];
    dt = map['dt'];
  }
}
