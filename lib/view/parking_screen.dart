import 'package:flutter/material.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/controller/profile_controller.dart';
import 'package:kkuparking/model/user_model.dart';
import 'package:kkuparking/view/home_screen.dart';
import 'package:kkuparking/view/profile_screen.dart';
import 'package:kkuparking/view/update_profile_screen.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  late UserModel _userModel;
  bool isloading = false;
  ProfileController controller = new ProfileController();

  void initState() {
    controller.getProfile(context).then((value) {
      setState(() {
        _userModel = value!;
        isloading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Scaffold(
            appBar: AppBar(
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
            drawer: Drawer(
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
            ),
            body: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width, //* 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/parking.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Parking",
                        style: TextStyle(
                          color: ToolsUtilites.whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ToolsUtilites.mainColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
