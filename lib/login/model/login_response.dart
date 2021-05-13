import 'package:login_cubit/core/model/base_model.dart';

class LoginResponse extends BaseModel<LoginResponse> {
  String? token;

  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  @override
  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
   return LoginResponse.fromJson(json);
  }
}