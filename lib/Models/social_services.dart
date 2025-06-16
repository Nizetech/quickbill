// To parse this JSON data, do
//
//     final socialServicceModel = socialServicceModelFromJson(jsonString);

import 'dart:convert';

SocialServicceModel socialServicceModelFromJson(String str) =>
    SocialServicceModel.fromJson(json.decode(str));

String socialServicceModelToJson(SocialServicceModel data) =>
    json.encode(data.toJson());

class SocialServicceModel {
  Section? section;
  List<Service>? services;
  double? balance;
  UserPurchaseInfo? userPurchaseInfo;

  SocialServicceModel({
    this.section,
    this.services,
    this.balance,
    this.userPurchaseInfo,
  });

  factory SocialServicceModel.fromJson(Map<String, dynamic> json) =>
      SocialServicceModel(
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
        balance: json["balance"]?.toDouble(),
        userPurchaseInfo: json["user_purchase_info"] == null
            ? null
            : UserPurchaseInfo.fromJson(json["user_purchase_info"]),
      );

  Map<String, dynamic> toJson() => {
        "section": section?.toJson(),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "balance": balance,
        "user_purchase_info": userPurchaseInfo?.toJson(),
      };
}

class Section {
  String? id;
  String? sectionName;
  String? sectionImage;
  String? locked;
  dynamic lockedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Section({
    this.id,
    this.sectionName,
    this.sectionImage,
    this.locked,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        sectionName: json["section_name"],
        sectionImage: json["section_image"],
        locked: json["locked"],
        lockedAt: json["locked_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_name": sectionName,
        "section_image": sectionImage,
        "locked": locked,
        "locked_at": lockedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Service {
  String? serviceId;
  String? serviceName;
  String? minQuantity;
  String? maxQuantity;
  String? description;
  String? cancelable;
  double? price;

  Service({
    this.serviceId,
    this.serviceName,
    this.minQuantity,
    this.maxQuantity,
    this.description,
    this.cancelable,
    this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        minQuantity: json["min_quantity"],
        maxQuantity: json["max_quantity"],
        description: json["description"],
        cancelable: json["cancelable"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_name": serviceName,
        "min_quantity": minQuantity,
        "max_quantity": maxQuantity,
        "description": description,
        "cancelable": cancelable,
        "price": price,
      };
}

class UserPurchaseInfo {
  dynamic purchaseLimited;
  dynamic purchasedAmount;
  dynamic purchaseLimitAmount;

  UserPurchaseInfo({
    this.purchaseLimited,
    this.purchasedAmount,
    this.purchaseLimitAmount,
  });

  factory UserPurchaseInfo.fromJson(Map<String, dynamic> json) =>
      UserPurchaseInfo(
        purchaseLimited: json["purchase_limited"],
          purchasedAmount: json["purchased_amount"],
          purchaseLimitAmount: json["purchase_limit_amount"]
          
      );

  Map<String, dynamic> toJson() => {
        "purchase_limited": purchaseLimited,
        "purchased_amount": purchasedAmount,
        "purchase_limit_amount": purchaseLimitAmount,
      };
}
