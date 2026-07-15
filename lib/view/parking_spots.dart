import 'package:flutter/material.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/controller/gate_controller.dart';
import 'package:kkuparking/model/spot_model.dart';

class ParkingSpots extends StatefulWidget {
  final int gateId;
  ParkingSpots({super.key, required this.gateId});

  @override
  State<ParkingSpots> createState() => _ParkingSpotsState();
}

class _ParkingSpotsState extends State<ParkingSpots> {
  bool isloading = false;
  GateController gateController = new GateController();
// ignore: prefer_typing_uninitialized_variables
  late List<SpotModel> listOfSpots;

  void initState() {
    gateController.getParkingSpotsById(widget.gateId, context).then((value) {
      setState(() {
        listOfSpots = value;
        isloading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gate ${widget.gateId} Parking Spots'),
        backgroundColor: ToolsUtilites.mainColor,
      ),
      body: isloading
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
              ),
              itemCount: listOfSpots.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      listOfSpots[index].name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
