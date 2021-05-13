class LoginResponse {
  String? token;

  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}