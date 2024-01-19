

import 'dart:convert';

List<ResponseModel> responseModelFromJson(String str) => List<ResponseModel>.from(json.decode(str).map((x) => ResponseModel.fromJson(x)));

String responseModelToJson(List<ResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseModel {
    int id;
    String name;
    String email;
    Gender gender;
    Status status;

    ResponseModel({
        required this.id,
        required this.name,
        required this.email,
        required this.gender,
        required this.status,
    });

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: genderValues.map[json["gender"]]!,
        status: statusValues.map[json["status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": genderValues.reverse[gender],
        "status": statusValues.reverse[status],
    };
}

enum Gender {
    female,
    male
}

final genderValues = EnumValues({
    "female": Gender.female,
    "male": Gender.male
});

enum Status {
    active,
    inactive
}

final statusValues = EnumValues({
    "active": Status.active,
    "inactive": Status.inactive
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
