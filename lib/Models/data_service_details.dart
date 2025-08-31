// To parse this JSON data, do
//
//     final dataServiceModel = dataServiceModelFromJson(jsonString);

import 'dart:convert';

DataServiceModel dataServiceModelFromJson(String str) =>
    DataServiceModel.fromJson(json.decode(str));

String dataServiceModelToJson(DataServiceModel data) =>
    json.encode(data.toJson());

class DataServiceModel {
  List<Detail>? recentPurchases;
  List<Detail>? details;
  int? balance;
  String? phone;

  DataServiceModel({
    this.recentPurchases,
    this.details,
    this.balance,
    this.phone,
  });

  factory DataServiceModel.fromJson(Map<String, dynamic> json) =>
      DataServiceModel(
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
  String? dataType;
  String? planId;
  String? planSize;
  String? planName;
  String? vtungPlanId;
  String? vtungPlanName;
  String? amount;
  String? phone;
  String? reference;
  String? status;
  String? apiMessage;
  String? apiStatus;
  String? promoCode;
  String? promoType;
  String? promoId;
  String? isPromoRewarded;
  String? createdAt;
  String? updatedAt;
  dynamic vtpassPlanId;
  dynamic vtpassPlanName;
  dynamic profit;
  String? details;

  Detail({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.dataType,
    this.planId,
    this.planSize,
    this.planName,
    this.vtungPlanId,
    this.vtungPlanName,
    this.amount,
    this.phone,
    this.reference,
    this.status,
    this.apiMessage,
    this.apiStatus,
    this.promoCode,
    this.promoType,
    this.promoId,
    this.isPromoRewarded,
    this.createdAt,
    this.updatedAt,
    this.vtpassPlanId,
    this.vtpassPlanName,
    this.profit,
    this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"],
        dataType: json["data_type"],
        planId: json["plan_id"],
        planSize: json["plan_size"],
        planName: json["plan_name"],
        vtungPlanId: json["vtung_plan_id"],
        vtungPlanName: json["vtung_plan_name"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        status: json["status"],
        apiMessage: json["api_message"],
        apiStatus: json["api_status"],
        promoCode: json["promo_code"],
        promoType: json["promo_type"],
        promoId: json["promo_id"],
        isPromoRewarded: json["is_promo_rewarded"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        vtpassPlanId: json["vtpass_plan_id"],
        vtpassPlanName: json["vtpass_plan_name"],
        profit: json["profit"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "network_id": networkId,
        "network_name": networkName,
        "data_type": dataType,
        "plan_id": planId,
        "plan_size": planSize,
        "plan_name": planName,
        "vtung_plan_id": vtungPlanId,
        "vtung_plan_name": vtungPlanName,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "status": status,
        "api_message": apiMessage,
        "api_status": apiStatus,
        "promo_code": promoCode,
        "promo_type": promoType,
        "promo_id": promoId,
        "is_promo_rewarded": isPromoRewarded,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "vtpass_plan_id": vtpassPlanId,
        "vtpass_plan_name": vtpassPlanName,
        "profit": profit,
        "details": details,
      };
}
