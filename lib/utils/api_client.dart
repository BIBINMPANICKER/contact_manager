import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  ApiClient() {
    initClient();
  }

  final String baseUrl = 'https://mock-rest-api-server.herokuapp.com';
  Dio dio;
  BaseOptions _baseOptions;

  //configuring Dio
  initClient() async {
    _baseOptions = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 1000000,
        contentType: ContentType.json,
        followRedirects: true,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

    dio = Dio(_baseOptions);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions reqOptions) {
        return reqOptions;
      },
      onError: (DioError dioError) {
        return dioError.response;
      },
    ));
  }

  Future<Response> getAllUsers() async {
    return dio.get("/api/v1/user/");
  }

  Future<Response> editUser(id, userModel) async {
    return dio.put("/api/v1/user/$id", data: userModel);
  }

  Future<Response> addUser(userModel) async {
    return dio.post("/api/v1/user", data: userModel);
  }

  Future<Response> deleteUser(id) async {
    return dio.delete("/api/v1/user/$id");
  }
}
