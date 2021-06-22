import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:questry/app/routes/routes_management.dart';
import '../../../data/User.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User user = User('', '');

  String emailvalidation(String value) {
    if (value.isEmpty) {
      return 'Enter something';
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return null;
    } else {
      return "Enter valid Email";
    }
  }

  String passValidation(String value) {
    if (value.isEmpty) {
      return 'Enter something';
    } else {
      return null;
    }
  }

  void submitSignIn() {
    if (formKey.currentState.validate()) {
      signInSave();
    } else {
      print("not ok");
    }
  }

  void submitSignUp() {
    if (formKey.currentState.validate()) {
      print("in sign up function");
      signUpSave();
    } else {
      print("not ok");
    }
  }

  Future signInSave() async {
    var url = Uri.parse("http://10.0.2.2:8800/api/auth/login");
    final res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': user.email, 'password': user.password}));
    print(res.body);
  }

  Future signUpSave() async {
    print("sign up save function");
    var url = Uri.parse("http://10.0.2.2:8800/api/auth/register");
    final res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': user.username,
          'email': user.email,
          'password': user.password
        }));
    print(res.body);
  }
}
