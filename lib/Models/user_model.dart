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
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? country;
  String? useGoogleAuth;
  bool? isActive;
  dynamic virtualAccount;
  bool? idVerified;
  bool? basicVerified;
  dynamic enabledPin;
  String? createdAt;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.country,
    this.useGoogleAuth,
    this.isActive,
    this.virtualAccount,
    this.idVerified,
    this.basicVerified,
    this.enabledPin,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        country: json["country"],
        useGoogleAuth: json["use_google_auth"],
        isActive: json["active"],
        virtualAccount: json["account_number"],
        idVerified: json["id_verified"],
        basicVerified: json["basic_verify"],
        enabledPin: json["enable_pin"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country": country,
        "use_google_auth": useGoogleAuth,
        "active": isActive,
        "account_number": virtualAccount,
        "id_verified": idVerified,
        "basic_verify": basicVerified,
        "enable_pin": enabledPin,
        "created_at": createdAt,
      };
}
