// To parse this JSON data, do
//
//     final domainListModel = domainListModelFromJson(jsonString);

import 'dart:convert';

DomainListModel domainListModelFromJson(String str) =>
    DomainListModel.fromJson(json.decode(str));

String domainListModelToJson(DomainListModel data) =>
    json.encode(data.toJson());

class DomainListModel {
  final List<DomainList>? domainList;
  final String? title;

  DomainListModel({
    this.domainList,
    this.title,
  });

  factory DomainListModel.fromJson(Map<String, dynamic> json) =>
      DomainListModel(
        domainList: json["domain_list"] == null
            ? []
            : List<DomainList>.from(
                json["domain_list"]!.map((x) => DomainList.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "domain_list": domainList == null
            ? []
            : List<dynamic>.from(domainList!.map((x) => x.toJson())),
        "title": title,
      };
}

class DomainList {
  final String? id;
  final String? userId;
  final String? dns;
  final String? amount;
  final String? period;
  final String? reference;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? autoRenew;
  final String? isConnected;
  final String? connectedAt;
  final String? purchaseHostingId;
  final dynamic profit;
  final String? expiryAt;
  final PurchaseHosting? purchaseHosting;
  final HostingPlan? hostingPlan;

  DomainList({
    this.id,
    this.userId,
    this.dns,
    this.amount,
    this.period,
    this.reference,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.autoRenew,
    this.isConnected,
    this.connectedAt,
    this.purchaseHostingId,
    this.profit,
    this.expiryAt,
    this.purchaseHosting,
    this.hostingPlan,
  });

  factory DomainList.fromJson(Map<String, dynamic> json) => DomainList(
        id: json["id"],
        userId: json["user_id"],
        dns: json["dns"],
        amount: json["amount"],
        period: json["period"],
        reference: json["reference"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        autoRenew: json["auto_renew"],
        isConnected: json["is_connected"],
        connectedAt: json["connected_at"],
        purchaseHostingId: json["purchase_hosting_id"],
        profit: json["profit"],
        expiryAt: json["expiry_at"],
        purchaseHosting: json["purchaseHosting"] == null
            ? null
            : PurchaseHosting.fromJson(json["purchaseHosting"]),
        hostingPlan: json["hostingPlan"] == null
            ? null
            : HostingPlan.fromJson(json["hostingPlan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "dns": dns,
        "amount": amount,
        "period": period,
        "reference": reference,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "auto_renew": autoRenew,
        "is_connected": isConnected,
        "connected_at": connectedAt,
        "purchase_hosting_id": purchaseHostingId,
        "profit": profit,
        "expiry_at": expiryAt,
        "purchaseHosting": purchaseHosting?.toJson(),
        "hostingPlan": hostingPlan?.toJson(),
      };
}

class HostingPlan {
  final String? type;
  final String? name;
  final String? level;

  HostingPlan({
    this.type,
    this.name,
    this.level,
  });

  factory HostingPlan.fromJson(Map<String, dynamic> json) => HostingPlan(
        type: json["type"],
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "level": level,
      };
}

class PurchaseHosting {
  final String? id;
  final String? userId;
  final String? hostingPlanId;
  final String? cost;
  final String? period;
  final String? reference;
  final String? status;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final String? isActive;
  final dynamic activatedAt;
  final dynamic expiryDate;
  final dynamic details;
  final dynamic profit;
  final dynamic promoCode;

  PurchaseHosting({
    this.id,
    this.userId,
    this.hostingPlanId,
    this.cost,
    this.period,
    this.reference,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.activatedAt,
    this.expiryDate,
    this.details,
    this.profit,
    this.promoCode,
  });

  factory PurchaseHosting.fromJson(Map<String, dynamic> json) =>
      PurchaseHosting(
        id: json["id"],
        userId: json["user_id"],
        hostingPlanId: json["hosting_plan_id"],
        cost: json["cost"],
        period: json["period"],
        reference: json["reference"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isActive: json["is_active"],
        activatedAt: json["activated_at"],
        expiryDate: json["expiry_date"],
        details: json["details"],
        profit: json["profit"],
        promoCode: json["promo_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "hosting_plan_id": hostingPlanId,
        "cost": cost,
        "period": period,
        "reference": reference,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "is_active": isActive,
        "activated_at": activatedAt,
        "expiry_date": expiryDate,
        "details": details,
        "profit": profit,
        "promo_code": promoCode,
      };
}
