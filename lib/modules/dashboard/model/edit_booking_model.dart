// To parse this JSON data, do
//
//     final editBookingsModel = editBookingsModelFromJson(jsonString);

import 'dart:convert';

EditBookingsModel editBookingsModelFromJson(String str) => EditBookingsModel.fromJson(json.decode(str));

String editBookingsModelToJson(EditBookingsModel data) => json.encode(data.toJson());

class EditBookingsModel {
  final int? status;
  final String? message;
  final Data ?data;

  EditBookingsModel({
    this.status,
    this.message,
    this.data,
  });

  factory EditBookingsModel.fromJson(Map<String, dynamic> json) => EditBookingsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
