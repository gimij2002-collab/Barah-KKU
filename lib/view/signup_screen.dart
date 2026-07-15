import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kkuparking/controller/signup_controller.dart';
import 'package:kkuparking/view/login_screen.dart';
import '../constant/tool_utilities.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  //RegisterController controller = Get.put(RegisterController());
  var nameController = TextEditingController();
  var universityNumberController = TextEditingController();
  var carNumberController = TextEditingController();
  var driverLicenseController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RegisterController controller = new RegisterController();

  File? image;
  final ImagePicker imagepicker = ImagePicker();

  bool isVisible = true;

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
      backgroundColor: ToolsUtilites.mainColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Container(
              decoration: BoxDecoration(
                color: ToolsUtilites.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      "Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: ToolsUtilites.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    //fullname
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your user name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintText: 'user name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),

                    //university Number
                    TextFormField(
                      controller: universityNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your university Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintText: 'University Number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //car Number
                    TextFormField(
                      controller: carNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your car Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintText: 'Car Number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //Driver License
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: image == null
                              ? Color.fromARGB(255, 235, 235, 235)
                              : ToolsUtilites.color1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),

                        height: 40, //MediaQuery.of(context).size.height * 0.1,
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
                    SizedBox(
                      height: 10,
                    ),

                    ////password
                    TextFormField(
                      onChanged: (value) => {},
                      controller: passwordController,
                      obscureText: isVisible,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintText: 'password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Icon(
                            isVisible == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: ToolsUtilites.blackColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
//Register button
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ToolsUtilites.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),

                        height: 60, //MediaQuery.of(context).size.height * 0.1,
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                image != null) {
                              controller.register(
                                  nameController.text,
                                  passwordController.text,
                                  emailController.text,
                                  carNumberController.text,
                                  universityNumberController.text,
                                  image!,
                                  context);
                              print("formKey");
                            }
                          },
                          child: const Center(
                            child: Text(
                              "Sign Up",
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Already have account?',
                          style: TextStyle(
                            color: ToolsUtilites.blackColor,
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: ToolsUtilites.mainColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
// class SignUpScreen extends GetWidget {
//   var formKey = GlobalKey<FormState>();
//   RegisterController controller = Get.put(RegisterController());
//   var nameController = TextEditingController();
//   var universityNumberController = TextEditingController();
//   var carNumberController = TextEditingController();
//   var driverLicenseController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();

//   SignUpScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
