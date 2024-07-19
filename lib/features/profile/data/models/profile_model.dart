// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String? message;
  final Customer? customer;

  ProfileModel({
    this.message,
    this.customer,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "customer": customer?.toJson(),
      };
}

class Customer {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
