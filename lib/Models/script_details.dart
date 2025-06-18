// To parse this JSON data, do
//
//     final scriptDetailModel = scriptDetailModelFromJson(jsonString);

import 'dart:convert';

ScriptDetailModel scriptDetailModelFromJson(String str) =>
    ScriptDetailModel.fromJson(json.decode(str));

String scriptDetailModelToJson(ScriptDetailModel data) =>
    json.encode(data.toJson());

class ScriptDetailModel {
  final Script? script;
  final List<dynamic>? relatedScripts;
  final User? user;
  final double? balance;
  final List<Review>? reviews;
  final dynamic review;
  final List<Sale>? sales;
  final String? title;
  final String? metaDescription;

  ScriptDetailModel({
    this.script,
    this.relatedScripts,
    this.user,
    this.balance,
    this.reviews,
    this.review,
    this.sales,
    this.title,
    this.metaDescription,
  });

  factory ScriptDetailModel.fromJson(Map<String, dynamic> json) =>
      ScriptDetailModel(
        script: json["script"] == null ? null : Script.fromJson(json["script"]),
        relatedScripts: json["related_scripts"] == null
            ? []
            : List<dynamic>.from(json["related_scripts"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        balance: json["balance"]?.toDouble(),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        review: json["review"],
        sales: json["sales"] == null
            ? []
            : List<Sale>.from(json["sales"]!.map((x) => Sale.fromJson(x))),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "script": script?.toJson(),
        "related_scripts": relatedScripts == null
            ? []
            : List<dynamic>.from(relatedScripts!.map((x) => x)),
        "user": user?.toJson(),
        "balance": balance,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "review": review,
        "sales": sales == null
            ? []
            : List<dynamic>.from(sales!.map((x) => x.toJson())),
        "title": title,
        "meta_description": metaDescription,
      };
}

class Review {
  final String? id;
  final String? userId;
  final String? scriptId;
  final String? status;
  final String? rate;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstName;
  final String? lastName;

  Review({
    this.id,
    this.userId,
    this.scriptId,
    this.status,
    this.rate,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        scriptId: json["script_id"],
        status: json["status"],
        rate: json["rate"],
        content: json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "script_id": scriptId,
        "status": status,
        "rate": rate,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
      };
}

class Sale {
  final String? id;
  final String? userId;
  final String? scriptId;
  final String? amount;
  final String? activeCode;
  final String? promoCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic profit;

  Sale({
    this.id,
    this.userId,
    this.scriptId,
    this.amount,
    this.activeCode,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        userId: json["user_id"],
        scriptId: json["script_id"],
        amount: json["amount"],
        activeCode: json["active_code"],
        promoCode: json["promo_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "script_id": scriptId,
        "amount": amount,
        "active_code": activeCode,
        "promo_code": promoCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profit": profit,
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
