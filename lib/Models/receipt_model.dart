// To parse this JSON data, do
//
//     final receiptModel = receiptModelFromJson(jsonString);

import 'dart:convert';

ReceiptModel receiptModelFromJson(String str) =>
    ReceiptModel.fromJson(json.decode(str));

String receiptModelToJson(ReceiptModel data) => json.encode(data.toJson());

class ReceiptModel {
  User? user;
  Info? info;
  String? service;

  ReceiptModel({
    this.user,
    this.info,
    this.service,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "info": info?.toJson(),
        "service": service,
      };
}

class Info {
  String? id;
  String? reference;
  String? amount;
  String? createdAt;
  String? title;
  String? token;
  String? unit;
  String? customerName;
  String? kct1;
  String? kct2;
  dynamic bonus;

  Info({
    this.id,
    this.reference,
    this.amount,
    this.createdAt,
    this.title,
    this.token,
    this.unit,
    this.customerName,
    this.kct1,
    this.kct2,
    this.bonus,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        reference: json["reference"],
        amount: json["amount"],
        createdAt: json["created_at"],
        title: json["title"],
        token: json["token"],
        unit: json["unit"],
        customerName: json["customer_name"],
        kct1: json["kct1"],
        kct2: json["kct2"],
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "amount": amount,
        "created_at": createdAt,
        "title": title,
        "token": token,
        "unit": unit,
        "customer_name": customerName,
        "kct1": kct1,
        "kct2": kct2,
        "bonus": bonus,
      };
}

class User {
  String? id;
  String? sessionId;
  String? sessionAt;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? country;
  String? referralId;
  String? referralUser;
  String? avatar;
  dynamic emailCode;
  dynamic emailCodeAt;
  String? verified;
  String? verifiedAt;
  String? referralCompleted;
  dynamic referralCompletedAt;
  String? isUnsubscribed;
  String? useGoogleAuth;
  String? googleAuthSecret;
  String? loginIp;
  String? locked;
  dynamic lockedAt;
  String? needVerify;
  String? deactivated;
  dynamic deactivatedAt;
  String? createdAt;
  String? updatedAt;
  dynamic role;
  dynamic popupDate;
  String? pin;
  String? enablePin;
  dynamic lastEvent;

  User({
    this.id,
    this.sessionId,
    this.sessionAt,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.country,
    this.referralId,
    this.referralUser,
    this.avatar,
    this.emailCode,
    this.emailCodeAt,
    this.verified,
    this.verifiedAt,
    this.referralCompleted,
    this.referralCompletedAt,
    this.isUnsubscribed,
    this.useGoogleAuth,
    this.googleAuthSecret,
    this.loginIp,
    this.locked,
    this.lockedAt,
    this.needVerify,
    this.deactivated,
    this.deactivatedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.popupDate,
    this.pin,
    this.enablePin,
    this.lastEvent,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        sessionId: json["session_id"],
        sessionAt: json["session_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        country: json["country"],
        referralId: json["referral_id"],
        referralUser: json["referral_user"],
        avatar: json["avatar"],
        emailCode: json["email_code"],
        emailCodeAt: json["email_code_at"],
        verified: json["verified"],
        verifiedAt: json["verified_at"],
        referralCompleted: json["referral_completed"],
        referralCompletedAt: json["referral_completed_at"],
        isUnsubscribed: json["is_unsubscribed"],
        useGoogleAuth: json["use_google_auth"],
        googleAuthSecret: json["google_auth_secret"],
        loginIp: json["login_ip"],
        locked: json["locked"],
        lockedAt: json["locked_at"],
        needVerify: json["need_verify"],
        deactivated: json["deactivated"],
        deactivatedAt: json["deactivated_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role: json["role"],
        popupDate: json["popup_date"],
        pin: json["pin"],
        enablePin: json["enable_pin"],
        lastEvent: json["last_event"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "session_at": sessionAt,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "country": country,
        "referral_id": referralId,
        "referral_user": referralUser,
        "avatar": avatar,
        "email_code": emailCode,
        "email_code_at": emailCodeAt,
        "verified": verified,
        "verified_at": verifiedAt,
        "referral_completed": referralCompleted,
        "referral_completed_at": referralCompletedAt,
        "is_unsubscribed": isUnsubscribed,
        "use_google_auth": useGoogleAuth,
        "google_auth_secret": googleAuthSecret,
        "login_ip": loginIp,
        "locked": locked,
        "locked_at": lockedAt,
        "need_verify": needVerify,
        "deactivated": deactivated,
        "deactivated_at": deactivatedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role": role,
        "popup_date": popupDate,
        "pin": pin,
        "enable_pin": enablePin,
        "last_event": lastEvent,
      };
}
