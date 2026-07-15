import 'package:flutter/material.dart';
import 'package:kkuparking/constant/general_URL.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/controller/profile_controller.dart';
import 'package:kkuparking/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: ToolsUtilites.whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: ToolsUtilites.whiteColor),
        ),
        backgroundColor: ToolsUtilites.mainColor,
      ),
      body: isloading
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "name: ${_userModel.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "email: ${_userModel.email}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "password: ${_userModel.password}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "car number: ${_userModel.carNumber}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "univercity number: ${_userModel.univNumber}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Driver license:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.6,
                    // decoration: BoxDecoration(
                    //   image: const DecorationImage(
                    //     image: NetworkImage(
                    //       imageUrl + _userModel.driverLicense),
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    child: Image.network(
                      imageUrl + "${_userModel.driverLicense}",
                      fit: BoxFit.fill,
                      height: 200,
                      width: 200,
                      scale: 1,
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
