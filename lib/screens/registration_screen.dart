import 'package:flutter/material.dart';
import 'package:task/models/request_model.dart';
import 'package:task/screens/user_details_screen.dart';
import 'package:task/services/dio_post_service.dart';
import 'package:task/util/color_constant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;
  String gender = "male";
  String status = "active";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 80, bottom: 32),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Hello! Register to get \nstarted',
                      style: TextStyle(
                          color: ColorConstant.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller:nameController ,
                  validator: (value) {
                    String namePattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = RegExp(namePattern);
                    if (value.toString().isEmpty) {
                      return "Cannot be Empty";
                    } else if (!regExp.hasMatch(value!)) {
                      return "Only Characters are allowed";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    
                      hintStyle: TextStyle(color: ColorConstant.grey),
                      filled: true,
                      hintText: 'Name',
                      fillColor: ColorConstant.lightGrey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                  validator: (value) {
                    String emailPattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(emailPattern);
                    if (value.toString().isEmpty) {
                      return "Cannot be Empty";
                    } else if (!regExp.hasMatch(value!)) {
                      return "@ and . is required";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: ColorConstant.grey),
                      filled: true,
                      hintText: 'Email',
                      fillColor: ColorConstant.lightGrey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                        flex: 1,
                        child: RadioListTile(
                          title: Text(
                            "Male",
                            style: TextStyle(color: ColorConstant.grey),
                          ),
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          title: Text(
                            "Female",
                            style: TextStyle(color: ColorConstant.grey),
                          ),
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
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
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff1E232C))),
                      onPressed: () async {
                        var snackBar;
                        if (_formKey.currentState!.validate()) {
                          const snackBar =
                              SnackBar(content: Text('User Registered!'));
                          RequestModel requestModel = RequestModel(
                              name: nameController.text,
                              email: emailController.text,
                              gender: gender,
                              status: "active");
                          bool isSuccess =
                              await PostData.postData(requestModel);
                          if (isSuccess && context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserDetailScreen(),
                                ));
                          } else {
                            const snackBar =
                                SnackBar(content: Text('User Not Registered!'));
                          }

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        'Registration',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
