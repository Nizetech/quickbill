// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

VerificationModel verificationModelFromJson(String str) =>
    VerificationModel.fromJson(json.decode(str));

String verificationModelToJson(VerificationModel data) =>
    json.encode(data.toJson());

class VerificationModel {
  SessionUser? sessionUser;
  String? verificationStatus;
  String? verifyType;
  String? rejectReason;
  String? idVerifiedAt;

  VerificationModel({
    this.sessionUser,
    this.verificationStatus,
    this.verifyType,
    this.rejectReason,
    this.idVerifiedAt,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      VerificationModel(
        sessionUser: json["session_user"] == null
            ? null
            : SessionUser.fromJson(json["session_user"]),
        verificationStatus: json["verification_status"],
        verifyType: json["verify_type"],
        rejectReason: json["reject_reason"],
        idVerifiedAt: json["id_verified_at"],
      );

  Map<String, dynamic> toJson() => {
        "session_user": sessionUser?.toJson(),
        "verification_status": verificationStatus,
        "verify_type": verifyType,
        "reject_reason": rejectReason,
        "id_verified_at": idVerifiedAt,
      };
}

class SessionUser {
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

  SessionUser({
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

  factory SessionUser.fromJson(Map<String, dynamic> json) => SessionUser(
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
