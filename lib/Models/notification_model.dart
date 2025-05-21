// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<Notification>? notifications;

  NotificationModel({
    this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification {
  String? id;
  String? userId;
  String? type;
  String? reference;
  String? amount;
  String? status;
  String? viewed;
  dynamic viewedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Notification({
    this.id,
    this.userId,
    this.type,
    this.reference,
    this.amount,
    this.status,
    this.viewed,
    this.viewedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        reference: json["reference"],
        amount: json["amount"],
        status: json["status"],
        viewed: json["viewed"],
        viewedAt: json["viewed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "reference": reference,
        "amount": amount,
        "status": status,
        "viewed": viewed,
        "viewed_at": viewedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
