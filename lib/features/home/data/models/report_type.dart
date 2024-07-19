// To parse this JSON data, do
//
//     final reportTypesModel = reportTypesModelFromJson(jsonString);

import 'dart:convert';

ReportTypesModel reportTypesModelFromJson(String str) =>
    ReportTypesModel.fromJson(json.decode(str));

String reportTypesModelToJson(ReportTypesModel data) =>
    json.encode(data.toJson());

class ReportTypesModel {
  final String? message;
  final List<ReportType>? reportTypes;

  ReportTypesModel({
    this.message,
    this.reportTypes,
  });

  factory ReportTypesModel.fromJson(Map<String, dynamic> json) =>
      ReportTypesModel(
        message: json["message"],
        reportTypes: json["reportTypes"] == null
            ? []
            : List<ReportType>.from(
                json["reportTypes"]!.map((x) => ReportType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "reportTypes": reportTypes == null
            ? []
            : List<dynamic>.from(reportTypes!.map((x) => x.toJson())),
      };
}

class ReportType {
  final String? id;
  final String? name;
  final String? description;

  ReportType({
    this.id,
    this.name,
    this.description,
  });

  factory ReportType.fromJson(Map<String, dynamic> json) => ReportType(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
