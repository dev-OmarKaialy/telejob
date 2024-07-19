// To parse this JSON data, do
//
//     final jobCategoriesModel = jobCategoriesModelFromJson(jsonString);

import 'dart:convert';

JobCategoriesModel jobCategoriesModelFromJson(String str) =>
    JobCategoriesModel.fromJson(json.decode(str));

String jobCategoriesModelToJson(JobCategoriesModel data) =>
    json.encode(data.toJson());

class JobCategoriesModel {
  final String? message;
  final List<JobCategory>? jobCategories;

  JobCategoriesModel({
    this.message,
    this.jobCategories,
  });

  factory JobCategoriesModel.fromJson(Map<String, dynamic> json) =>
      JobCategoriesModel(
        message: json["message"],
        jobCategories: json["jobCategories"] == null
            ? []
            : List<JobCategory>.from(
                json["jobCategories"]!.map((x) => JobCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "jobCategories": jobCategories == null
            ? []
            : List<dynamic>.from(jobCategories!.map((x) => x.toJson())),
      };
}

class JobCategory {
  final String? id;
  final String? name;
  final String? description;

  JobCategory({
    this.id,
    this.name,
    this.description,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
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
