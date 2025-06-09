// To parse this JSON data, do
//
//     final dataPlansModel = dataPlansModelFromJson(jsonString);

import 'dart:convert';

DataPlansModel dataPlansModelFromJson(String str) =>
    DataPlansModel.fromJson(json.decode(str));

String dataPlansModelToJson(DataPlansModel data) => json.encode(data.toJson());

class DataPlansModel {
  String? api;
  List<Plan>? plans;

  DataPlansModel({
    this.api,
    this.plans,
  });

  factory DataPlansModel.fromJson(Map<String, dynamic> json) => DataPlansModel(
        api: json["api"],
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "api": api,
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
      };
}

class Plan {
  String? planId;
  String? name;
  int? price;
  String? networkId;

  Plan({
    this.planId,
    this.name,
    this.price,
    this.networkId,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        planId: json["plan_id"],
        name: json["name"],
        price: json["price"],
        networkId: json["network_id"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "name": name,
        "price": price,
        "network_id": networkId,
      };
}
