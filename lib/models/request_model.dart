
import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
    String email;
    String name;
    String gender;
    String status;

    RequestModel({
        required this.email,
        required this.name,
        required this.gender,
        required this.status,
    });

    factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "gender": gender,
        "status": status,
    };
}
