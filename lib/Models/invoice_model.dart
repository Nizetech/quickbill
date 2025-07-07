// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  final bool? result;
  final String? invoiceNumber;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;

  InvoiceModel({
    this.result,
    this.invoiceNumber,
    this.bankName,
    this.accountName,
    this.accountNumber,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        result: json["result"],
        invoiceNumber: json["invoice_number"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "invoice_number": invoiceNumber,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
      };
}
