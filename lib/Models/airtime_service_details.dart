// To parse this JSON data, do
//
//     final airtimeServiceModel = airtimeServiceModelFromJson(jsonString);

import 'dart:convert';

AirtimeServiceModel airtimeServiceModelFromJson(String str) =>
    AirtimeServiceModel.fromJson(json.decode(str));

String airtimeServiceModelToJson(AirtimeServiceModel data) =>
    json.encode(data.toJson());

class AirtimeServiceModel {
  List<Detail>? recentPurchases;
  List<Detail>? details;
  int? balance;
  String? phone;

  AirtimeServiceModel({
    this.recentPurchases,
    this.details,
    this.balance,
    this.phone,
  });

  factory AirtimeServiceModel.fromJson(Map<String, dynamic> json) =>
      AirtimeServiceModel(
        recentPurchases: json["recent_purchases"] == null
            ? []
            : List<Detail>.from(
                json["recent_purchases"]!.map((x) => Detail.fromJson(x))),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        balance: json["balance"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "recent_purchases": recentPurchases == null
            ? []
            : List<dynamic>.from(recentPurchases!.map((x) => x.toJson())),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "balance": balance,
        "phone": phone,
      };
}

class Detail {
  String? id;
  String? userId;
  String? networkId;
  String? networkName;
  String? airtimeType;
  String? amount;
  String? phone;
  String? reference;
  String? status;
  String? apiMessage;
  String? apiStatus;
  String? promoCode;
  String? promoType;
  String? promoId;
  String? createdAt;
  String? updatedAt;
  dynamic profit;
  String? details;

  Detail({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.airtimeType,
    this.amount,
    this.phone,
    this.reference,
    this.status,
    this.apiMessage,
    this.apiStatus,
    this.promoCode,
    this.promoType,
    this.promoId,
    this.createdAt,
    this.updatedAt,
    this.profit,
    this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"],
        airtimeType: json["airtime_type"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        status: json["status"],
        apiMessage: json["api_message"],
        apiStatus: json["api_status"],
        promoCode: json["promo_code"],
        promoType: json["promo_type"],
        promoId: json["promo_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        profit: json["profit"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "network_id": networkId,
        "network_name": networkName,
        "airtime_type": airtimeType,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "status": status,
        "api_message": apiMessage,
        "api_status": apiStatus,
        "promo_code": promoCode,
        "promo_type": promoType,
        "promo_id": promoId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "profit": profit,
        "details": details,
      };
}
