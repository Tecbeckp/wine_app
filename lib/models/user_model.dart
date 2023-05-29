class UserModel {
  dynamic fcmToken;
  String displayName;
  String email;
  dynamic imageUrl;
  dynamic address;
  dynamic bio;
  dynamic phoneNumber;
  dynamic paidSubscription;
  dynamic subScriptionDate;

  UserModel({
    required this.fcmToken,
    required this.displayName,
    required this.email,
    required this.imageUrl,
    required this.address,
    required this.bio,
    required this.phoneNumber,
    this.paidSubscription = false,
    this.subScriptionDate = "",
  });

  factory UserModel.fromDocument(var data) {
    return UserModel(
        paidSubscription: data['paidSubscription'],
        subScriptionDate: data['SubscriptionDate'],
        fcmToken: data['FcmToken'],
        email: data['email'],
        displayName: data['displayName'],
        imageUrl: data['imageUrl'],
        address: data['address'] ?? "",
        bio: data['bio'] ?? "",
        phoneNumber: data['phoneNUmber']);
  }
}
