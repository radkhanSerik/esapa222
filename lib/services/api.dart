import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.pbf.kz/api';
  late String bearerToken;
  late String seriesController;
  late String numberController;

  ApiService(this.bearerToken) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Добавляем Bearer токен в заголовки запроса
          options.headers['Authorization'] = 'Bearer $bearerToken';
          return handler.next(options);
        },
      ),
    );

    // ignore: deprecated_member_use
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> initialize(String login, String password) async {
    try {
      Response<Map<String, dynamic>> authResponse =
          await _dio.post<Map<String, dynamic>>(
        '$baseUrl/Authentication/Login',
        data: {
          "login": "login",
          "password": "password",
        },
      );
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      // Обработка ошибок при выполнении запроса
      print('Error resetting password: $e');
      if (e.response?.statusCode == 401) {
        // Ваш код для обработки ошибки 400
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', '');
        await prefs.setString('role', '');
        await prefs.setString('login', '');
        await prefs.setString('displayName', '');
        await prefs.setString('id', '');
        await prefs.setBool('isInspector', false);

        await updateToken();

        bool? isInspector = prefs.getBool('isInspector');
      }
      throw Exception('Error resetting password: $e');
    }
  }

  Future<String> getAccessToken() async {
    try {
      Map<String, dynamic> requestData = {
        "accessId": "825e0a72-c23c-44c0-b8bc-55e831b1d508",
      };

      Response<Map<String, dynamic>> response = await _dio
          .post<Map<String, dynamic>>('$baseUrl/Authentication/GetAccessToken',
              data: requestData);

      if (response.data != null && response.data!.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data?["token"]);
        return response.data?["token"];
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updateToken() async {
    try {
      String newToken = await getAccessToken();
      bearerToken = newToken;
      _dio.options.headers['Authorization'] = 'Bearer $bearerToken';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isInspector', false);
    } catch (e) {
      throw Exception('Error updating token: $e');
    }
  }

  Future<Response<Map<String, dynamic>>> fetchData() async {
    try {
      return await _dio.get<Map<String, dynamic>>('$baseUrl/get');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Response<Map<String, dynamic>>> checkScan(String code) async {
    try {
      Map<String, dynamic> requestData = {
        "usid": code,
        "series": "",
        "number": "",
        "udid": "",
        "checkerData": {
          "prescriptionId": "",
          "checkedOrgBin": "",
          "checkedOrgName": "",
          "checkedAddress": "",
        },
        "location": [0, 0],
      };

      Response<Map<String, dynamic>> response =
          await _dio.post<Map<String, dynamic>>('$baseUrl/Checker/CheckCode',
              data: requestData);
      print(response.data);
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Response<Map<String, dynamic>>> handCheckScan(
      String seriesController, String numberController) async {
    try {
      Map<String, dynamic> requestData = {
        "usid": "",
        "series": seriesController,
        "number": numberController,
        "udid": "",
        "checkerData": {
          "prescriptionId": "",
          "checkedOrgBin": "",
          "checkedOrgName": "",
          "checkedAddress": "",
        },
        "location": [0, 0],
      };

      Response<Map<String, dynamic>> response =
          await _dio.post<Map<String, dynamic>>('$baseUrl/Checker/CheckCode',
              data: requestData);
      print(response.data);
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

// Проверка почты и отправка ссылки на смену

  Future<String> resetPassword(String email) async {
    try {
      // Получите новый токен, если требуется обновление
      await updateToken();

      Response<dynamic> authResponse = await _dio.post<dynamic>(
        '$baseUrl/Authentication/ResetPassword',
        data: {
          "email": email,
        },
      );

      // Проверяем успешность запроса
      if (authResponse.statusCode == 200) {
        // Проверяем, что тело ответа содержит "OK"
        if (authResponse.data == "OK") {
          // Ваш успешный код здесь
          print('Password reset successful!');
          return 'OK'; // Возвращаем "OK" в качестве результата
        } else {
          // Обработка случая, когда ответ не содержит "OK"
          print(
              'Password reset failed. Unexpected response: ${authResponse.data}');
          throw Exception(
              'Password reset failed. Unexpected response: ${authResponse.data}');
        }
      } else if (authResponse.statusCode == 400) {
        // Обработка случая, когда ответ имеет статус 400 и содержит "Email not found"
        if (authResponse.data == "Email не найден") {
          print('Password reset failed. Email not found.');
          return 'Email not found'; // Возвращаем "Email not found" в качестве результата
        } else {
          // Обработка других случаев с кодом 400
          print(
              'Password reset failed. Unexpected response: ${authResponse.data}');
          throw Exception(
              'Password reset failed. Unexpected response: ${authResponse.data}');
        }
      } else {
        // Обработка ошибок в других статусах
        print('Password reset failed. Status code: ${authResponse.statusCode}');
        throw Exception(
            'Password reset failed. Status code: ${authResponse.statusCode}');
      }
    } on DioError catch (e) {
      // Обработка ошибок при выполнении запроса
      print('Error resetting password: $e');
      if (e.response?.statusCode == 400) {
        // Ваш код для обработки ошибки 400
        print('Error 400: ${e.response?.data}');
      }
      throw Exception('Error resetting password: $e');
    }
  }

  authenticateUser(String text, String text2) {}
}
