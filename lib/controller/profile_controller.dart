import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kkuparking/constant/general_URL.dart';
import 'package:kkuparking/model/user_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dio/dio.dart' as dio;

class ProfileController {
  Future<UserModel?> getProfile(context) async {
    var dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final user_id = prefs.get(key);
    var formData = FormData.fromMap({
      'id': user_id,
    });

    var response =
        await dio.post('$serverUrl/get_profile_student', data: formData);

    if (response.statusCode == 200 && response.data['status'] == "1") {
      print("######## profile:    ${response.data['data']}");
      print("######## profile2:    ${response.data["data"]}");

      try {
        return UserModel.fromJson(response.data["data"]);
      } catch (error) {
        print("####   error get profile ${error}");
        return null;
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: response.data['error'],
        // btnOkOnPress: () {},
      ).show();
    }
    return null;
  }

  updateProfile(String name, String password, String car_number, String email,
      File image, String univ_number, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final user_id = prefs.get(key);
    String fileName = image.path.split("/").last;
    var formData = FormData.fromMap({
      "id": user_id,
      'name': name,
      'password': password,
      'car_number': car_number,
      'email': email,
      "driver_license":
          await MultipartFile.fromFile(image.path, filename: fileName),
      'univ_number': univ_number,
    });
    var dio = Dio();
    var response = await dio.post('$serverUrl/update_student', data: formData);
    if (response.statusCode == 200 && response.data['status'] == "1") {
      print(response.data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: response.data['message'],
        btnOkOnPress: () {},
      ).show();
    } else {
      print("error update profile    ${response.data}");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: response.data['error'],
        // btnOkOnPress: () {},
      ).show();
    }
  }
}
