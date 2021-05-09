import 'package:flutter/material.dart';

import 'login/view/login_view.dart';

void main() => runApp(LoginCubitApp());

class LoginCubitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "login_cubit",
      home: LoginView(),
      theme: ThemeData.dark(),
    );
  }
}

