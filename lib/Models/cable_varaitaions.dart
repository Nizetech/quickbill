// To parse this JSON data, do
//
//     final cableVariations = cableVariationsFromJson(jsonString);

import 'dart:convert';

CableVariations cableVariationsFromJson(String str) =>
    CableVariations.fromJson(json.decode(str));

String cableVariationsToJson(CableVariations data) =>
    json.encode(data.toJson());

class CableVariations {
  String api;
  List<Plan> plans;

  CableVariations({
    required this.api,
    required this.plans,
  });

  factory CableVariations.fromJson(Map<String, dynamic> json) =>
      CableVariations(
        api: json["api"],
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "api": api,
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
      };
}

class Plan {
  String variationCode;
  String name;
  int variationAmount;

  Plan({
    required this.variationCode,
    required this.name,
    required this.variationAmount,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        variationCode: json["variation_code"],
        name: json["name"],
        variationAmount: json["variation_amount"],
      );

  Map<String, dynamic> toJson() => {
        "variation_code": variationCode,
        "name": name,
        "variation_amount": variationAmount,
      };
}
