import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:kkuparking/constant/general_URL.dart';
import 'package:kkuparking/view/parking_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Future login(String email, String password, context) async {
    var dio = Dio();
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    var response = await dio.post('$serverUrl/login_student', data: formData);

    if (response.statusCode == 200 && response.data['status'] == "1") {
      print(response.data);
      _save(response.data['data']['id'].toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message']),
          backgroundColor: Colors.green[200],
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParkingScreen()),
      );
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: response.data['error']['email'].toString() +
            response.data['error']['password'].toString(),
        // btnOkOnPress: () {},
      ).show();
    }
  }_save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


}
