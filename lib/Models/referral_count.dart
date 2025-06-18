// To parse this JSON data, do
//
//     final referralCountModel = referralCountModelFromJson(jsonString);

import 'dart:convert';

ReferralCountModel referralCountModelFromJson(String str) =>
    ReferralCountModel.fromJson(json.decode(str));

String referralCountModelToJson(ReferralCountModel data) =>
    json.encode(data.toJson());

class ReferralCountModel {
  final String? referralId;
  final List<Referral>? referrals;
  final int? sumEarned;

  ReferralCountModel({
    this.referralId,
    this.referrals,
    this.sumEarned,
  });

  factory ReferralCountModel.fromJson(Map<String, dynamic> json) =>
      ReferralCountModel(
        referralId: json["referral_id"],
        referrals: json["referrals"] == null
            ? []
            : List<Referral>.from(
                json["referrals"]!.map((x) => Referral.fromJson(x))),
        sumEarned: json["sum_earned"],
      );

  Map<String, dynamic> toJson() => {
        "referral_id": referralId,
        "referrals": referrals == null
            ? []
            : List<dynamic>.from(referrals!.map((x) => x.toJson())),
        "sum_earned": sumEarned,
      };
}

class Referral {
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime? createdAt;
  final String? amount;
  final DateTime? rewardAt;

  Referral({
    this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.amount,
    this.rewardAt,
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        amount: json["amount"],
        rewardAt: json["reward_at"] == null
            ? null
            : DateTime.parse(json["reward_at"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "created_at": createdAt?.toIso8601String(),
        "amount": amount,
        "reward_at": rewardAt?.toIso8601String(),
      };
}
