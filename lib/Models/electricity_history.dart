// To parse this JSON data, do
//
//     final electricityHistoryModel = electricityHistoryModelFromJson(jsonString);

import 'dart:convert';

ElectricityHistoryModel electricityHistoryModelFromJson(String str) =>
    ElectricityHistoryModel.fromJson(json.decode(str));

String electricityHistoryModelToJson(ElectricityHistoryModel data) =>
    json.encode(data.toJson());

class ElectricityHistoryModel {
  String? fromDate;
  // ToDate? toDate;
  List<Transaction>? transactions;

  ElectricityHistoryModel({
    this.fromDate,
    // this.toDate,
    this.transactions,
  });

  factory ElectricityHistoryModel.fromJson(Map<String, dynamic> json) =>
      ElectricityHistoryModel(
        fromDate: json["from_date"],
        // toDate:
        //     json["to_date"] == null ? null : ToDate.fromJson(json["to_date"]),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate,
        // "to_date": toDate?.toJson(),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class ToDate {
  String? date;
  int? timezoneType;
  String? timezone;

  ToDate({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory ToDate.fromJson(Map<String, dynamic> json) => ToDate(
        date: json["date"],
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class Transaction {
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

  Transaction({
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

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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
