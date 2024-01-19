import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:task/models/response_model.dart';

class DioApiService {
  static Future<List<ResponseModel>> getData() async {
    List<dynamic> userData = [];
    List<ResponseModel> datas = [];
    var dio = Dio();
    Response response;
    try {
      response = await dio.get('https://gorest.co.in/public/v2/users',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
            },
          ));

      if (response.statusCode == 200) {
        log("response.statusCode is ${response.statusCode}");

        log("response.data is ${response.data}");
        userData = response.data;
        datas = userData.map((e) {
          return ResponseModel.fromJson(e);
        }).toList();

        log('Data is $datas');
      }
      log("${datas.length}");
    } catch (e) {
      log('Error sending request!');
    }
    return datas;
  }
}
