import 'package:flutter/material.dart';
import 'package:task/models/request_model.dart';
import 'package:task/models/response_model.dart';
import 'package:task/screens/user_details_screen.dart';
import 'package:task/services/dio_get_service.dart';
import 'package:task/services/dio_update_service.dart';
import 'package:task/util/color_constant.dart';
import 'package:task/util/strings.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;
  String gender = "male";
  String status = "active";
  late Future<List<ResponseModel>>? futureData;
  @override
  void initState() {
    super.initState();
    futureData = DioApiService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.lightGrey,
      body: SingleChildScrollView(
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
                    hintText: Strings.stringName,
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
                    hintText: Strings.stringEmail,
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
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1E232C))),
                    onPressed: () {
                      setState(() {
                        RequestModel requestModel = RequestModel(
                            email: emailController.text,
                            name: nameController.text,
                            gender: gender,
                            status: status);
                        UpdateApi.updateData(requestModel, IdConstant.getId);
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserDetailScreen(),
                          ));
                      futureData = DioApiService.getData();
                    },
                    child: const Text(
                      'Update Data',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
