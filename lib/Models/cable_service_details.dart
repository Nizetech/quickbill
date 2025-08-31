// To parse this JSON data, do
//
//     final cableServiceModel = cableServiceModelFromJson(jsonString);

import 'dart:convert';

CableServiceModel cableServiceModelFromJson(String str) =>
    CableServiceModel.fromJson(json.decode(str));

String cableServiceModelToJson(CableServiceModel data) =>
    json.encode(data.toJson());

class CableServiceModel {
  List<Detail>? recentPurchases;
  List<Detail>? details;
  int? balance;
  String? phone;

  CableServiceModel({
    this.recentPurchases,
    this.details,
    this.balance,
    this.phone,
  });

  factory CableServiceModel.fromJson(Map<String, dynamic> json) =>
      CableServiceModel(
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
  String? amount;
  String? phone;
  String? reference;
  String? apiStatus;
  String? status;
  String? apiMessage;
  String? promoId;
  String? promoCode;
  String? promoType;
  String? profit;
  String? createdAt;
  String? updatedAt;
  String? smartCard;
  String? purchasedCode;
  String? package;
  String? details;

  Detail({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.amount,
    this.phone,
    this.reference,
    this.apiStatus,
    this.status,
    this.apiMessage,
    this.promoId,
    this.promoCode,
    this.promoType,
    this.profit,
    this.createdAt,
    this.updatedAt,
    this.smartCard,
    this.purchasedCode,
    this.package,
    this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        apiStatus: json["api_status"],
        status: json["status"],
        apiMessage: json["api_message"],
        promoId: json["promo_id"],
        promoCode: json["promo_code"],
        promoType: json["promo_type"],
        profit: json["profit"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        smartCard: json["smart_card"],
        purchasedCode: json["purchased_code"],
        package: json["package"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "network_id": networkId,
        "network_name": networkName,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "api_status": apiStatus,
        "status": status,
        "api_message": apiMessage,
        "promo_id": promoId,
        "promo_code": promoCode,
        "promo_type": promoType,
        "profit": profit,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "smart_card": smartCard,
        "purchased_code": purchasedCode,
        "package": package,
        "details": details,
      };
}
