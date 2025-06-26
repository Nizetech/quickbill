// To parse this JSON data, do
//
//     final repairTransactions = repairTransactionsFromJson(jsonString);

import 'dart:convert';

RepairTransactions repairTransactionsFromJson(String str) =>
    RepairTransactions.fromJson(json.decode(str));

String repairTransactionsToJson(RepairTransactions data) =>
    json.encode(data.toJson());

class RepairTransactions {
  final List<RepairList>? repairList;
  final String? title;
  final String? metaDescription;

  RepairTransactions({
    this.repairList,
    this.title,
    this.metaDescription,
  });

  factory RepairTransactions.fromJson(Map<String, dynamic> json) =>
      RepairTransactions(
        repairList: json["repair_list"] == null
            ? []
            : List<RepairList>.from(
                json["repair_list"]!.map((x) => RepairList.fromJson(x))),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "repair_list": repairList == null
            ? []
            : List<dynamic>.from(repairList!.map((x) => x.toJson())),
        "title": title,
        "meta_description": metaDescription,
      };
}

class RepairList {
  final String? id;
  final String? userId;
  final String? repairType;
  final String? appointmentPickupDate;
  final String? vehicleStatus;
  final String? vehicleMake;
  final String? vehicleModel;
  final String? vehicleYear;
  final String? partAccessoryProcurement;
  final String? description;
  final String? replacedPartHandling;
  final String? agentContactNumber;
  final String? agentContactName;
  final String? amount;
  final String? reference;
  final String? invoiceStatus;
  final String? status;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final String? photo;
  final dynamic profit;
  final dynamic promoCode;
  final String? worksNotPaid;

  RepairList({
    this.id,
    this.userId,
    this.repairType,
    this.appointmentPickupDate,
    this.vehicleStatus,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleYear,
    this.partAccessoryProcurement,
    this.description,
    this.replacedPartHandling,
    this.agentContactNumber,
    this.agentContactName,
    this.amount,
    this.reference,
    this.invoiceStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.photo,
    this.profit,
    this.promoCode,
    this.worksNotPaid,
  });

  factory RepairList.fromJson(Map<String, dynamic> json) => RepairList(
        id: json["id"],
        userId: json["user_id"],
        repairType: json["repair_type"],
        appointmentPickupDate: json["appointment_pickup_date"],
        vehicleStatus: json["vehicle_status"],
        vehicleMake: json["vehicle_make"],
        vehicleModel: json["vehicle_model"],
        vehicleYear: json["vehicle_year"],
        partAccessoryProcurement: json["part_accessory_procurement"],
        description: json["description"],
        replacedPartHandling: json["replaced_part_handling"],
        agentContactNumber: json["agent_contact_number"],
        agentContactName: json["agent_contact_name"],
        amount: json["amount"].toString(),
        reference: json["reference"],
        invoiceStatus: json["invoice_status"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        photo: json["photo"],
        profit: json["profit"],
        promoCode: json["promo_code"],
        worksNotPaid: json["works_not_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "repair_type": repairType,
        "appointment_pickup_date": appointmentPickupDate,
        "vehicle_status": vehicleStatus,
        "vehicle_make": vehicleMake,
        "vehicle_model": vehicleModel,
        "vehicle_year": vehicleYear,
        "part_accessory_procurement": partAccessoryProcurement,
        "description": description,
        "replaced_part_handling": replacedPartHandling,
        "agent_contact_number": agentContactNumber,
        "agent_contact_name": agentContactName,
        "amount": amount,
        "reference": reference,
        "invoice_status": invoiceStatus,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "photo": photo,
        "profit": profit,
        "promo_code": promoCode,
        "works_not_paid": worksNotPaid,
      };
}
