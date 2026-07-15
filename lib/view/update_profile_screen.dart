import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kkuparking/constant/tool_utilities.dart';
import 'package:kkuparking/controller/profile_controller.dart';
import 'package:kkuparking/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {


  late UserModel _userModel;
  bool isloading = false;
  ProfileController controller = new ProfileController();

  var formKey = GlobalKey<FormState>();
  File? image;

  final ImagePicker imagepicker = ImagePicker();

  var emailController = TextEditingController();
  var fullnameController = TextEditingController();
  var passwordController = TextEditingController();
  var carNumberController = TextEditingController();
  var univNumberController = TextEditingController();
  void initState() {
    controller.getProfile(context).then((value) {
      _userModel = value!;
      setState(() {
        isloading = true;
      });
      fullnameController.text = _userModel.name;
      emailController.text = _userModel.email;
      passwordController.text = _userModel.password;
      carNumberController.text = _userModel.carNumber;
      univNumberController.text = _userModel.univNumber;
      // image = File(imageUrl + "${_userModel.driverLicense}");
      //print("@@@@@@@@image.path    ${image?.path}");
    });

    super.initState();
  }

  uploadImage(String type) async {
    var pickedImage;
    if (type == "gallary") {
      pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    }
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        print("path   ${pickedImage.path}");
        print("name:   ${pickedImage.name}");
        print("file name:     ${pickedImage.path.split('/').last}");
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            setState(() {
              isloading = false;
            });
            Navigator.pop(context);
          },
          child:
              Icon(Icons.arrow_back_outlined, color: ToolsUtilites.whiteColor),
        ),
        backgroundColor: ToolsUtilites.mainColor,
      ),
      body: Form(
        key: formKey,
        child: isloading
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update Profile",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ToolsUtilites.blackColor),
                      ),

                      Text(
                        "name:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ToolsUtilites.blackColor),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: fullnameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f5f8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'Full name',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Email Address:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: ToolsUtilites.blackColor,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      //email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f5f8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'email',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Password:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: ToolsUtilites.blackColor,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      //email
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f5f8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'password',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "car number:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: ToolsUtilites.blackColor,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      //carnumber
                      TextFormField(
                        controller: carNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your car number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f5f8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'car number',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "university number:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: ToolsUtilites.blackColor,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      //university Number
                      TextFormField(
                        controller: univNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your car number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff1f5f8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: 'university number:',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Driver License
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: image == null
                                ? Colors.red[100]
                                : ToolsUtilites.color1,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),

                          height:
                              40, //MediaQuery.of(context).size.height * 0.1,
                          child: TextButton(
                            onPressed: () {
                              uploadImage("gallary");
                            },
                            child: const Center(
                              child: Text(
                                "Upload Driver License",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      image == null
                          ? Text(
                              "choose image for driver license",
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ToolsUtilites.mainColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          height: 60,
                          child: TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  image != null) {
                                await controller.updateProfile(
                                    fullnameController.text,
                                    passwordController.text,
                                    carNumberController.text,
                                    emailController.text,
                                    image!,
                                    univNumberController.text,
                                    context);

                                print("formKey");
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Confirm",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
