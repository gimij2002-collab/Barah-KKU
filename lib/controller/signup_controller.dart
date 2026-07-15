import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kkuparking/constant/general_URL.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/view/parking_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class RegisterController {
  Future register(String name, String password, String email, String car_number,
      String univ_number, File image, context) async {
    String fileName = image.path.split("/").last;
    var formData = FormData.fromMap({
      'name': name,
      'password': password,
      'email': email,
      'car_number': car_number,
      'univ_number': univ_number,
      "driver_license":
          await MultipartFile.fromFile(image.path, filename: fileName),
    });
    var dio = Dio();
    var response =
        await dio.post('$serverUrl/register_student', data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      _save(response.data['data']['id'].toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('create account successfully'),
          backgroundColor: ToolsUtilites.mainColor,
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
        title: response.data['error'],
        // btnOkOnPress: () {},
      ).show();
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
}
