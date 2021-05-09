import 'package:dio/dio.dart';

import '../enum/login_enum.dart';
import '../extension/login_extension.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

abstract class ILoginService{
  final Dio dio;

  ILoginService(this.dio);

  String get loginPath => ILoginServicePath.LOGIN.value;

  Future<LoginResponse?> loginRequest(LoginRequest loginRequest);
  
}