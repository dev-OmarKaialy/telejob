// To parse this JSON data, do
//
//     final indexRequestsModel = indexRequestsModelFromJson(jsonString);

import 'dart:convert';

IndexRequestsModel indexRequestsModelFromJson(String str) =>
    IndexRequestsModel.fromJson(json.decode(str));

String indexRequestsModelToJson(IndexRequestsModel data) =>
    json.encode(data.toJson());

class IndexRequestsModel {
  final String? message;
  final List<RequestModel>? requests;

  IndexRequestsModel({
    this.message,
    this.requests,
  });

  factory IndexRequestsModel.fromJson(Map<String, dynamic> json) =>
      IndexRequestsModel(
        message: json["message"],
        requests: json["requests"] == null
            ? []
            : List<RequestModel>.from(
                json["requests"]!.map((x) => RequestModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "requests": requests == null
            ? []
            : List<dynamic>.from(requests!.map((x) => x.toJson())),
      };
}

class RequestModel {
  final String? id;
  final Worker? worker;
  final String? jobDescription;
  final String? status;
  final List<Worker>? jobCategories;

  RequestModel({
    this.id,
    this.worker,
    this.jobDescription,
    this.status,
    this.jobCategories,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["_id"],
        worker: json["worker"] == null ? null : Worker.fromJson(json["worker"]),
        jobDescription: json["jobDescription"],
        status: json["status"],
        jobCategories: json["JobCategories"] == null
            ? []
            : List<Worker>.from(
                json["JobCategories"]!.map((x) => Worker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "worker": worker?.toJson(),
        "jobDescription": jobDescription,
        "status": status,
        "JobCategories": jobCategories == null
            ? []
            : List<dynamic>.from(jobCategories!.map((x) => x.toJson())),
      };
}

class Worker {
  final String? id;
  final String? name;

  Worker({
    this.id,
    this.name,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {};
}
