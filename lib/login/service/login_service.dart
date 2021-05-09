import 'dart:io';

import 'package:dio/dio.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';
import 'i_login_service.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponse?> loginRequest(LoginRequest loginRequest) async {
    final response = await dio.post(loginPath, data: loginRequest);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("fail");
    }
  }
}
