// To parse this JSON data, do
//
//     final electServiceModel = electServiceModelFromJson(jsonString);

import 'dart:convert';

ElectServiceModel electServiceModelFromJson(String str) =>
    ElectServiceModel.fromJson(json.decode(str));

String electServiceModelToJson(ElectServiceModel data) =>
    json.encode(data.toJson());

class ElectServiceModel {
  List<Detail>? details;


  ElectServiceModel({

    this.details,

  });

  factory ElectServiceModel.fromJson(Map<String, dynamic> json) =>
      ElectServiceModel(

        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {

        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),

      };
}

class Detail {
  String? meterNumber;
  String? discoName;
  String? meterType;
  String? customerName;
  String? address;


  Detail({
    this.discoName,
    this.meterNumber,
    this.meterType,
    this.customerName,
    this.address,

  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(

        discoName: json["disco_name"],
        meterNumber: json["meter_number"],
        meterType: json["meter_type"],
        customerName: json["customer_name"],
        address: json["address"],


      );

  Map<String, dynamic> toJson() => {

        "disco_name": discoName,
        "meter_number": meterNumber,
        "meter_type": meterType,
        "address": address,

      };
}
