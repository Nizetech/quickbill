// To parse this JSON data, do
//
//     final socialBoostHistoryModel = socialBoostHistoryModelFromJson(jsonString);

import 'dart:convert';

SocialBoostHistoryModel socialBoostHistoryModelFromJson(String str) =>
    SocialBoostHistoryModel.fromJson(json.decode(str));

String socialBoostHistoryModelToJson(SocialBoostHistoryModel data) =>
    json.encode(data.toJson());

class SocialBoostHistoryModel {
  final bool? result;
  final List<Datum>? data;

  SocialBoostHistoryModel({
    this.result,
    this.data,
  });

  factory SocialBoostHistoryModel.fromJson(Map<String, dynamic> json) =>
      SocialBoostHistoryModel(
        result: json["result"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final String? userId;
  final String? serviceId;
  final String? serviceName;
  final String? socialLink;
  final String? quantity;
  final String? price;
  final String? cancelable;
  final String? reference;
  final dynamic promoCode;
  final String? status;
  final String? apiStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic profit;

  Datum({
    this.id,
    this.userId,
    this.serviceId,
    this.serviceName,
    this.socialLink,
    this.quantity,
    this.price,
    this.cancelable,
    this.reference,
    this.promoCode,
    this.status,
    this.apiStatus,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        socialLink: json["social_link"],
        quantity: json["quantity"],
        price: json["price"],
        cancelable: json["cancelable"],
        reference: json["reference"],
        promoCode: json["promo_code"],
        status: json["status"],
        apiStatus: json["api_status"],
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
        "service_id": serviceId,
        "service_name": serviceName,
        "social_link": socialLink,
        "quantity": quantity,
        "price": price,
        "cancelable": cancelable,
        "reference": reference,
        "promo_code": promoCode,
        "status": status,
        "api_status": apiStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profit": profit,
      };
}
