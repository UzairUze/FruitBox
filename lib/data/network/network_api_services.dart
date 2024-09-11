import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:getx_mvvm/data/app_exceptions.dart';
import '../base_apii_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  /// for get api response
  @override
  Future getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  /// for post api response
  @override
  Future postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

      ///internet error show here
    } on SocketException {
      throw InternetException('');

      /// request time out error show here.
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    /// using switch case for return the response of api and error Exceptions.
    switch (response.statusCode) {
      case 200:

        ///if user login successful
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:

        ///if user not found then this show
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error occurred while communication with server ${response.statusCode}');
    }
  }
}
