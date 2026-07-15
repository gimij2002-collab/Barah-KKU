import 'package:flutter/material.dart';
import 'package:kkuparking/constant/general_URL.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/model/gate_model.dart';
import 'package:dio/dio.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:dio/dio.dart' as dio;
import 'package:kkuparking/model/spot_model.dart';

class GateController {
  Future<List<GateModel>> getGates(context) async {
    final response = await Dio().post('$serverUrl/get_gates');

    print("######## gates:    ${response.data['data']}");

    final data = response.data["data"] as List<dynamic>;

    if (response.statusCode == 200 && response.data['status'] == "1") {
      print("######## gates:    ${response.data['data']}");

      final listOfGates = data.map((json) => GateModel.fromJson(json)).toList();

      print("&&&&&&&&&&&    listOfGate ${listOfGates[0].name.toString()}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message']),
          backgroundColor: ToolsUtilites.mainColor,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      return listOfGates;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: response.data['error'],
        // btnOkOnPress: () {},
      ).show();
    }
    return [];
  }

  Future<List<SpotModel>> getParkingSpotsById(int gateId, context) async {
    var formData = FormData.fromMap({
      'gate_id': gateId,
    });
    final response =
        await Dio().post('$serverUrl/get_parking_spots', data: formData);
    print("######## get_parking_spots:    ${response.data['data']}");
    final data = response.data["data"] as List<dynamic>;
    if (response.statusCode == 200 && response.data['status'] == "1") {
      print("######## get_parking_spots:    ${response.data['data']}");
      final listOfSpots = data.map((json) => SpotModel.fromJson(json)).toList();
      print("&&&&&&&&&&&    listOfSpots ${listOfSpots.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message']),
          backgroundColor: ToolsUtilites.mainColor,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      return listOfSpots;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: response.data['error'],
        // btnOkOnPress: () {},
      ).show();
    }
    return [];
  }
}
