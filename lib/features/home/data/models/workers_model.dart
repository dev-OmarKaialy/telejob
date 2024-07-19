import 'dart:convert';

import 'job_categories.dart';

IndexWorkersModel indexWorkersModelFromJson(String str) =>
    IndexWorkersModel.fromJson(json.decode(str));

String indexWorkersModelToJson(IndexWorkersModel data) =>
    json.encode(data.toJson());

class IndexWorkersModel {
  final String? message;
  final List<WorkersModel>? workers;

  IndexWorkersModel({
    this.message,
    this.workers,
  });

  factory IndexWorkersModel.fromJson(Map<String, dynamic> json) =>
      IndexWorkersModel(
        message: json["message"],
        workers: json["workers"] == null
            ? []
            : List<WorkersModel>.from(
                json["workers"]!.map((x) => WorkersModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "workers": workers == null
            ? []
            : List<dynamic>.from(workers!.map((x) => x.toJson())),
      };
}

WorkersModel workersModelFromJson(String str) =>
    WorkersModel.fromJson(json.decode(str));

String workersModelToJson(WorkersModel data) => json.encode(data.toJson());

class WorkersModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? description;
  final List<JobCategory>? jobCategories;

  WorkersModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.description,
    this.jobCategories,
  });

  factory WorkersModel.fromJson(Map<String, dynamic> json) => WorkersModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        description: json["description"],
        jobCategories: json["JobCategories"] == null
            ? []
            : List<JobCategory>.from(
                json["JobCategories"]!.map((x) => JobCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "description": description,
        "JobCategories": jobCategories == null
            ? []
            : List<dynamic>.from(jobCategories!.map((x) => x.toJson())),
      };
}
