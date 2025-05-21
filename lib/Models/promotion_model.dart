// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  ActivePromo? activePromo;
  List<UserPromo>? userPromos;

  PromoModel({
    this.activePromo,
    this.userPromos,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        activePromo: json["active_promo"] == null
            ? null
            : ActivePromo.fromJson(json["active_promo"]),
        userPromos: json["user_promos"] == null
            ? []
            : List<UserPromo>.from(
                json["user_promos"]!.map((x) => UserPromo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active_promo": activePromo?.toJson(),
        "user_promos": userPromos == null
            ? []
            : List<dynamic>.from(userPromos!.map((x) => x.toJson())),
      };
}

class ActivePromo {
  String? id;
  String? title;
  String? type;
  String? promoImage;
  String? description;
  String? userAmount;
  String? balanceRewardUsers;
  String? network;
  String? dataType;
  String? planSize;
  String? planId;
  String? planName;
  String? vtungPlanId;
  String? vtungPlanName;
  String? planAmount;
  String? x2RewardUsers;
  String? otherOffers;
  String? otherImage;
  String? otherRewardUsers;
  DateTime? startDate;
  DateTime? endDate;
  String? activated;
  dynamic activatedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic vtpassPlanId;
  dynamic vtpassPlanName;

  ActivePromo({
    this.id,
    this.title,
    this.type,
    this.promoImage,
    this.description,
    this.userAmount,
    this.balanceRewardUsers,
    this.network,
    this.dataType,
    this.planSize,
    this.planId,
    this.planName,
    this.vtungPlanId,
    this.vtungPlanName,
    this.planAmount,
    this.x2RewardUsers,
    this.otherOffers,
    this.otherImage,
    this.otherRewardUsers,
    this.startDate,
    this.endDate,
    this.activated,
    this.activatedAt,
    this.createdAt,
    this.updatedAt,
    this.vtpassPlanId,
    this.vtpassPlanName,
  });

  factory ActivePromo.fromJson(Map<String, dynamic> json) => ActivePromo(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        promoImage: json["promo_image"],
        description: json["description"],
        userAmount: json["user_amount"],
        balanceRewardUsers: json["balance_reward_users"],
        network: json["network"],
        dataType: json["data_type"],
        planSize: json["plan_size"],
        planId: json["plan_id"],
        planName: json["plan_name"],
        vtungPlanId: json["vtung_plan_id"],
        vtungPlanName: json["vtung_plan_name"],
        planAmount: json["plan_amount"],
        x2RewardUsers: json["x2_reward_users"],
        otherOffers: json["other_offers"],
        otherImage: json["other_image"],
        otherRewardUsers: json["other_reward_users"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        activated: json["activated"],
        activatedAt: json["activated_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vtpassPlanId: json["vtpass_plan_id"],
        vtpassPlanName: json["vtpass_plan_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "promo_image": promoImage,
        "description": description,
        "user_amount": userAmount,
        "balance_reward_users": balanceRewardUsers,
        "network": network,
        "data_type": dataType,
        "plan_size": planSize,
        "plan_id": planId,
        "plan_name": planName,
        "vtung_plan_id": vtungPlanId,
        "vtung_plan_name": vtungPlanName,
        "plan_amount": planAmount,
        "x2_reward_users": x2RewardUsers,
        "other_offers": otherOffers,
        "other_image": otherImage,
        "other_reward_users": otherRewardUsers,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "activated": activated,
        "activated_at": activatedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "vtpass_plan_id": vtpassPlanId,
        "vtpass_plan_name": vtpassPlanName,
      };
}

class UserPromo {
  DateTime? createdAt;
  String? service;
  String? promoCode;

  UserPromo({
    this.createdAt,
    this.service,
    this.promoCode,
  });

  factory UserPromo.fromJson(Map<String, dynamic> json) => UserPromo(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        service: json["service"],
        promoCode: json["promo_code"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "service": service,
        "promo_code": promoCode,
      };
}
