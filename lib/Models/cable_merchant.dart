// To parse this JSON data, do
//
//     final merchantModel = merchantModelFromJson(jsonString);

import 'dart:convert';

MerchantModel merchantModelFromJson(String str) =>
    MerchantModel.fromJson(json.decode(str));

String merchantModelToJson(MerchantModel data) => json.encode(data.toJson());

class MerchantModel {
  bool result;
  Res res;

  MerchantModel({
    required this.result,
    required this.res,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
        result: json["result"],
        res: Res.fromJson(json["res"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "res": res.toJson(),
      };
}

class Res {
  String code;
  Content content;

  Res({
    required this.code,
    required this.content,
  });

  factory Res.fromJson(Map<String, dynamic> json) => Res(
        code: json["code"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "content": content.toJson(),
      };
}

class Content {
  String? customerName;
  String? status;
  String? dueDate;
  String? customerNumber;
  String? customerType;
  CommissionDetails? commissionDetails;

  Content({
    this.customerName,
    this.status,
    this.dueDate,
    this.customerNumber,
    this.customerType,
    this.commissionDetails,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        customerName: json["Customer_Name"],
        status: json["Status"],
        dueDate: json["Due_Date"],
        customerNumber: json["Customer_Number"],
        customerType: json["Customer_Type"],
        commissionDetails:
            CommissionDetails.fromJson(json["commission_details"]),
      );

  Map<String, dynamic> toJson() => {
        "Customer_Name": customerName,
        "Status": status,
        "Due_Date": dueDate,
        "Customer_Number": customerNumber,
        "Customer_Type": customerType,
        "commission_details": commissionDetails?.toJson(),
      };
}

class CommissionDetails {
  dynamic amount;
  String rate;
  String rateType;
  String computationType;

  CommissionDetails({
    required this.amount,
    required this.rate,
    required this.rateType,
    required this.computationType,
  });

  factory CommissionDetails.fromJson(Map<String, dynamic> json) =>
      CommissionDetails(
        amount: json["amount"],
        rate: json["rate"],
        rateType: json["rate_type"],
        computationType: json["computation_type"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "rate": rate,
        "rate_type": rateType,
        "computation_type": computationType,
      };
}
