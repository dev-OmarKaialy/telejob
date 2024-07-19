// To parse this JSON data, do
//
//     final authResponseMOdel = authResponseMOdelFromJson(jsonString);

import 'dart:convert';

AuthResponseModel authResponseMOdelFromJson(String str) =>
    AuthResponseModel.fromJson(json.decode(str));

String authResponseMOdelToJson(AuthResponseModel data) =>
    json.encode(data.toJson());

class AuthResponseModel {
  final String? message;
  final String? jwt;

  AuthResponseModel({
    this.message,
    this.jwt,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        message: json["message"],
        jwt: json["JWT"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "JWT": jwt,
      };
}
