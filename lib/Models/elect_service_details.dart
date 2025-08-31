// To parse this JSON data, do
//
//     final electServiceModel = electServiceModelFromJson(jsonString);

import 'dart:convert';

ElectServiceModel electServiceModelFromJson(String str) =>
    ElectServiceModel.fromJson(json.decode(str));

String electServiceModelToJson(ElectServiceModel data) =>
    json.encode(data.toJson());

class ElectServiceModel {
  List<Network>? networks;
  List<Detail>? recentPurchases;
  List<Detail>? details;
  int? balance;
  String? phone;

  ElectServiceModel({
    this.networks,
    this.recentPurchases,
    this.details,
    this.balance,
    this.phone,
  });

  factory ElectServiceModel.fromJson(Map<String, dynamic> json) =>
      ElectServiceModel(
        networks: json["networks"] == null
            ? []
            : List<Network>.from(
                json["networks"]!.map((x) => Network.fromJson(x))),
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
        "networks": networks == null
            ? []
            : List<dynamic>.from(networks!.map((x) => x.toJson())),
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
  String? discoType;
  String? discoName;
  String? meterNumber;
  String? meterType;
  String? amount;
  String? phone;
  String? reference;
  String? status;
  String? apiStatus;
  String? apiMessage;
  String? promoId;
  String? promoCode;
  String? promoType;
  dynamic profit;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? customerName;
  String? token;
  dynamic bonus;
  String? kct1;
  String? kct2;
  String? unit;
  String? details;

  Detail({
    this.id,
    this.userId,
    this.discoType,
    this.discoName,
    this.meterNumber,
    this.meterType,
    this.amount,
    this.phone,
    this.reference,
    this.status,
    this.apiStatus,
    this.apiMessage,
    this.promoId,
    this.promoCode,
    this.promoType,
    this.profit,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.customerName,
    this.token,
    this.bonus,
    this.kct1,
    this.kct2,
    this.unit,
    this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        discoType: json["disco_type"],
        discoName: json["disco_name"],
        meterNumber: json["meter_number"],
        meterType: json["meter_type"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        status: json["status"],
        apiStatus: json["api_status"],
        apiMessage: json["api_message"],
        promoId: json["promo_id"],
        promoCode: json["promo_code"],
        promoType: json["promo_type"],
        profit: json["profit"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        address: json["address"],
        customerName: json["customer_name"],
        token: json["token"],
        bonus: json["bonus"],
        kct1: json["kct1"],
        kct2: json["kct2"],
        unit: json["unit"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "disco_type": discoType,
        "disco_name": discoName,
        "meter_number": meterNumber,
        "meter_type": meterType,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "status": status,
        "api_status": apiStatus,
        "api_message": apiMessage,
        "promo_id": promoId,
        "promo_code": promoCode,
        "promo_type": promoType,
        "profit": profit,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "address": address,
        "customer_name": customerName,
        "token": token,
        "bonus": bonus,
        "kct1": kct1,
        "kct2": kct2,
        "unit": unit,
        "details": details,
      };
}

class Network {
  String? network;
  int? networkId;

  Network({
    this.network,
    this.networkId,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        network: json["network"],
        networkId: json["networkId"],
      );

  Map<String, dynamic> toJson() => {
        "network": network,
        "networkId": networkId,
      };
}
