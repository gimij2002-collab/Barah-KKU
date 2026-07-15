import 'package:flutter/material.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/controller/gate_controller.dart';
import 'package:kkuparking/controller/profile_controller.dart';
import 'package:kkuparking/model/gate_model.dart';
import 'package:kkuparking/model/user_model.dart';
import 'package:kkuparking/view/parking_spots.dart';
import 'package:kkuparking/view/profile_screen.dart';
import 'package:kkuparking/view/update_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel _userModel;
  bool isloading = false;
  ProfileController controller = new ProfileController();
  GateController gateController = new GateController();
// ignore: prefer_typing_uninitialized_variables
  late List<GateModel> listOfGates;
  bool isloadingGates = false;

  void initState() {
    controller.getProfile(context).then((value) {
      setState(() {
        _userModel = value!;
        isloading = true;
      });
    });
    gateController.getGates(context).then((value) {
      setState(() {
        listOfGates = value;
        isloadingGates = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Gates",
          style: TextStyle(
            color: ToolsUtilites.whiteColor,
          ),
        ),
        actions: [
          Icon(
            Icons.car_repair,
            color: ToolsUtilites.whiteColor,
            size: 30,
          ),
          SizedBox(width: 20),
          Icon(
            Icons.notifications,
            color: ToolsUtilites.whiteColor,
            size: 30,
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: ToolsUtilites.mainColor,
      ),
      drawer: isloading
          ? Drawer(
              backgroundColor: ToolsUtilites.whiteColor,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    color: ToolsUtilites.mainColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        Text(
                          "name: ${_userModel.name}",
                          style: TextStyle(
                              color: ToolsUtilites.whiteColor, fontSize: 20),
                        ),
                        Text(
                          "${_userModel.email}",
                          style: TextStyle(
                              color: ToolsUtilites.whiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    textColor: ToolsUtilites.blackColor,
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.edit_note),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: ToolsUtilites.blackColor,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile()),
                      );
                      controller.getProfile(context).then((value) {
                        setState(() {
                          _userModel = value!;
                          isloading = true;
                        });
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: ToolsUtilites.blackColor,
                    onTap: () {
                      // Handle "About Us" logic here
                    },
                  ),
                  Divider(),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
      body: isloadingGates
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: listOfGates.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ToolsUtilites.mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ParkingSpots(gateId: index + 1),
                              ),
                            );
                          },
                          title: Card(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                listOfGates[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  // backgroundColor: ToolsUtilites.mainColor,
                                ),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.forward,
                                color: ToolsUtilites.whiteColor,
                              )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
