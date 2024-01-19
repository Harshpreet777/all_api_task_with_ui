import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/models/request_model.dart';
import 'package:task/screens/user_details_screen.dart';
import 'package:task/services/dio_update_service.dart';
import 'package:task/util/color_constant.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen(
      {super.key,
      required this.userId,
      this.userName,
      this.userEmail,
      this.userGender,
      required this.userStatus});
  final int userId;
  final String? userName;
  final String? userEmail;
  final String? userGender;
  final String userStatus;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;
  String? gender;
  String status = "active";

  @override
  void initState() {
    super.initState();
    
    nameController.text = widget.userName ?? "";
    emailController.text = widget.userEmail ?? "";
    gender = widget.userGender ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.lightGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 80, bottom: 32),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Update User Data',
                      style: TextStyle(
                          color: ColorConstant.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: ColorConstant.grey),
                      filled: true,
                      hintText: widget.userName,
                      fillColor: ColorConstant.lightGrey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: ColorConstant.borderColorE8ECF4,
                            style: BorderStyle.solid,
                            width: 1),
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: ColorConstant.grey),
                      filled: true,
                      hintText: widget.userEmail,
                      fillColor: ColorConstant.lightGrey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: ColorConstant.borderColorE8ECF4,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ColorConstant.borderColorE8ECF4,
                          style: BorderStyle.solid,
                          width: 1)),
                  child: Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                            color: ColorConstant.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: Text(
                            "Male",
                            style: TextStyle(color: ColorConstant.grey),
                          ),
                          value: 'male',
                          groupValue: gender ,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: Text(
                            "Female",
                            style: TextStyle(color: ColorConstant.grey),
                          ),
                          value: 'female',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff1E232C))),
                      onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String updatedName = nameController.text;
                        String updatedEmail = emailController.text;
                        String updatedGender = gender ??" ";
          
                        if (updatedName != widget.userName ||
                            updatedEmail != widget.userEmail ||
                            updatedGender != widget.userGender) {
                          RequestModel requestModel =
                              RequestModel(
                            name: updatedName,
                            email: updatedEmail,
                            gender: updatedGender,
                            status: "active",
                          );
                          bool isSuccess = await UpdateApi.updateData(
                            requestModel,
                            widget.userId,
                          );
                          if (isSuccess && context.mounted) {
                            const snackBar = SnackBar(
                              content: Text("User Details updated"),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserDetailScreen()));
                          } else {
                            log("Email already exists...");
                            const snackBar = SnackBar(
                              content: Text(
                                  "Email already exists..."),
                              duration: Duration(seconds: 2),
                            );
                            if (context.mounted) {
          
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        } else {
                          log(" email already exists...");
                          const snackBar = SnackBar(
                            content: Text(
                                "Email already exists..."),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }},
                      child: const Text(
                        'Update Data',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
