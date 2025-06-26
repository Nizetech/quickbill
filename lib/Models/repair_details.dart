// To parse this JSON data, do
//
//     final repairDetailsModel = repairDetailsModelFromJson(jsonString);

import 'dart:convert';

RepairDetailsModel repairDetailsModelFromJson(String str) =>
    RepairDetailsModel.fromJson(json.decode(str));

String repairDetailsModelToJson(RepairDetailsModel data) =>
    json.encode(data.toJson());

class RepairDetailsModel {
  final List<AutoRepairHistory>? autoRepairHistory;
  final String? title;
  final String? metaDescription;

  RepairDetailsModel({
    this.autoRepairHistory,
    this.title,
    this.metaDescription,
  });

  factory RepairDetailsModel.fromJson(Map<String, dynamic> json) =>
      RepairDetailsModel(
        autoRepairHistory: json["auto_repair_history"] == null
            ? []
            : List<AutoRepairHistory>.from(json["auto_repair_history"]!
                .map((x) => AutoRepairHistory.fromJson(x))),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "auto_repair_history": autoRepairHistory == null
            ? []
            : List<dynamic>.from(autoRepairHistory!.map((x) => x.toJson())),
        "title": title,
        "meta_description": metaDescription,
      };
}

class AutoRepairHistory {
  final String? id;
  final String? section;
  final String? detail;
  final String? work;
  final String? cost;
  final String? status;
  final DateTime? createdAt;
  final dynamic updatedAt;

  AutoRepairHistory({
    this.id,
    this.section,
    this.detail,
    this.work,
    this.cost,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AutoRepairHistory.fromJson(Map<String, dynamic> json) =>
      AutoRepairHistory(
        id: json["id"],
        section: json["section"],
        detail: json["detail"],
        work: json["work"],
        cost: json["cost"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section": section,
        "detail": detail,
        "work": work,
        "cost": cost,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
