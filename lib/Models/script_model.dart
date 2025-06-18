// To parse this JSON data, do
//
//     final scriptModel = scriptModelFromJson(jsonString);

import 'dart:convert';

ScriptModel scriptModelFromJson(String str) =>
    ScriptModel.fromJson(json.decode(str));

String scriptModelToJson(ScriptModel data) => json.encode(data.toJson());

class ScriptModel {
  final List<Script>? scripts;
  final User? user;
  final double? balance;
  final String? title;
  final String? metaDescription;

  ScriptModel({
    this.scripts,
    this.user,
    this.balance,
    this.title,
    this.metaDescription,
  });

  factory ScriptModel.fromJson(Map<String, dynamic> json) => ScriptModel(
        scripts: json["scripts"] == null
            ? []
            : List<Script>.from(
                json["scripts"]!.map((x) => Script.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        balance: json["balance"]?.toDouble(),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "scripts": scripts == null
            ? []
            : List<dynamic>.from(scripts!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "balance": balance,
        "title": title,
        "meta_description": metaDescription,
      };
}

class Script {
  final String? id;
  final String? title;
  final String? image;
  final String? demoUrl;
  final String? attachName;
  final String? attachPath;
  final String? categories;
  final String? price;
  final String? description;
  final String? views;
  final String? published;
  final DateTime? publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? scriptCategories;
  final String? sales;
  final String? reviews;

  Script({
    this.id,
    this.title,
    this.image,
    this.demoUrl,
    this.attachName,
    this.attachPath,
    this.categories,
    this.price,
    this.description,
    this.views,
    this.published,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.scriptCategories,
    this.sales,
    this.reviews,
  });

  factory Script.fromJson(Map<String, dynamic> json) => Script(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        demoUrl: json["demo_url"],
        attachName: json["attach_name"],
        attachPath: json["attach_path"],
        categories: json["categories"],
        price: json["price"],
        description: json["description"],
        views: json["views"],
        published: json["published"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        scriptCategories: json["script_categories"],
        sales: json["sales"],
        reviews: json["reviews"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "demo_url": demoUrl,
        "attach_name": attachName,
        "attach_path": attachPath,
        "categories": categories,
        "price": price,
        "description": description,
        "views": views,
        "published": published,
        "published_at": publishedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "script_categories": scriptCategories,
        "sales": sales,
        "reviews": reviews,
      };
}

class User {
  final String? id;
  final String? sessionId;
  final DateTime? sessionAt;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? country;
  final String? referralId;
  final dynamic referralUser;
  final String? avatar;
  final dynamic emailCode;
  final dynamic emailCodeAt;
  final String? verified;
  final DateTime? verifiedAt;
  final String? referralCompleted;
  final dynamic referralCompletedAt;
  final String? isUnsubscribed;
  final String? useGoogleAuth;
  final String? googleAuthSecret;
  final String? loginIp;
  final String? locked;
  final dynamic lockedAt;
  final String? needVerify;
  final String? deactivated;
  final dynamic deactivatedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic role;

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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        sessionId: json["session_id"],
        sessionAt: json["session_at"] == null
            ? null
            : DateTime.parse(json["session_at"]),
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
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "session_at": sessionAt?.toIso8601String(),
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
        "verified_at": verifiedAt?.toIso8601String(),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role,
      };
}
