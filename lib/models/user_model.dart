class UserModel {
  dynamic fcmToken;
  String displayName;
  String email;
  dynamic imageUrl;
  dynamic address;
  dynamic bio;
  dynamic phoneNumber;
  bool notification;

  UserModel({
    required this.fcmToken,
    required this.displayName,
    required this.email,
    required this.imageUrl,
    required this.address,
    required this.bio,
    required this.phoneNumber,
    this.notification = true,
  });

  factory UserModel.fromDocument(var data) {
    return UserModel(
        notification: data['notification'] ?? true,
        fcmToken: data['FcmToken'],
        email: data['email'],
        displayName: data['displayName'],
        imageUrl: data['imageUrl'],
        address: data['address'] ?? "",
        bio: data['bio'] ?? "",
        phoneNumber: data['phoneNUmber']);
  }
}
