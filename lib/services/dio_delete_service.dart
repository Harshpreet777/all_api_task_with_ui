import 'dart:developer';

import 'package:dio/dio.dart';

class DeleteApi {
  static Future<bool> deleteData({int? id}) async {
    var dio = Dio();
    try {
      final response =
          await dio.delete('https://gorest.co.in/public/v2/users/$id',
              options: Options(
                headers: {
                  "Content-Type": "application/json",
                  "Authorization":
                      "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
                },
              ));
      if (response.statusCode == 200) {
        log("response.data is ${response.data}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }
}
