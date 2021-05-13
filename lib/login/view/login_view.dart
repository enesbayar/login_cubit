import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/login_service.dart';
import '../viewmodel/cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  final TextEditingController eMailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final String baseUrl = 'https://reqres.in/api';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(
            eMailController, passwordController, formKey,
            loginService: LoginService(Dio(BaseOptions(baseUrl: baseUrl)))),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              buildShowDialog(context, state);
            }
          },
          builder: (context, state) {
            return buildPage(context, state);
          },
        ));
  }

  Widget buildPage(BuildContext context, LoginState state) {
    return SafeArea(
          child: Scaffold(
        appBar: buildAppBar,
        body: buildLoginFields(context, state),
      ),
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      title: Text('Login'),
      centerTitle: true,
    );
  }

  Form buildLoginFields(context, LoginState state) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode(state),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextFormFieldMail,
          buildTextFormFieldPassword,
          buildButtonCubit(context)
        ],
      ),
    );
  }

  Widget buildButtonCubit(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginCompleted) {
          return Column(
            children: [
              buildElevatedButton(context),
              Text(state.loginResponse.token ?? '')
            ],
          );
        } else {
          return buildElevatedButton(context);
        }
      },
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context) => ElevatedButton(
      onPressed: () => _onPressed(context), child: Text('Login'));

  void _onPressed(BuildContext context) =>
      context.read<LoginCubit>().loginRequest();

  Widget get buildTextFormFieldPassword {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: passwordController,
          validator: (value) =>
              (value ?? '').length > 6 ? null : 'must be at least 6 characters',
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: ' password ')),
    );
  }

  Widget get buildTextFormFieldMail {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: eMailController,
          validator: (value) =>
              (value ?? '').isNotEmpty ? null : 'must not be empty',
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: ' e-mail ')),
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) => state
          is LoginValidateState
      ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
      : AutovalidateMode.disabled;

  Future buildShowDialog(BuildContext context, LoginFailed state) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(state.errorMessage),
          );
        });
  }
}
