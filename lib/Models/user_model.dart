// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? result;
  User? user;

  UserModel({
    this.result,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        result: json["result"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "user": user?.toJson(),
      };
}

class User {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? country;
  String? useGoogleAuth;
  bool? idVerified;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.country,
    this.useGoogleAuth,
    this.idVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        country: json["country"],
        useGoogleAuth: json["use_google_auth"],
        idVerified: json["id_verified"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country": country,
        "use_google_auth": useGoogleAuth,
        "id_verified": idVerified,
      };
}
