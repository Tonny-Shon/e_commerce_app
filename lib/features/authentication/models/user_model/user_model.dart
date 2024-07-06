import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

//Constructor for user model
  UserModel(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  //Helper function to get the full name
  String get fullname => '$firstname $lastname';

  //formatting the phoneNo
  String get formattedPhoneNo => EFormatter.formatPhoneNumber(phoneNumber);

  //static function to split the full name into first and last name
  static List<String> nameParts(fullname) => fullname.split(' ');

  //static function to generate a username from the full name
  static String generateUsername(fullname) {
    List<String> nameParts = fullname.split(' ');
    String firstname = nameParts[0].toLowerCase();
    String lastname = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        '$firstname$lastname'; //Combine first and last name
    String usernameWithPrefix = 'cut_$camelCaseUsername';

    return usernameWithPrefix;
  }

  //static functiont to create an empty user model.
  static UserModel empty() => UserModel(
      id: '',
      firstname: '',
      lastname: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  //convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstname,
      'LastName': lastname,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  //factory to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstname: data['FirstName'] ?? '',
          lastname: data['LastName'] ?? '',
          username: data['UserName'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else {
      throw Exception('Document data is null');
    }
  }
}
