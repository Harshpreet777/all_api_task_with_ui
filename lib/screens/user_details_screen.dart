import 'package:flutter/material.dart';
import 'package:task/models/response_model.dart';
import 'package:task/screens/update_screen.dart';
import 'package:task/services/dio_delete_service.dart';
import 'package:task/services/dio_get_service.dart';
import 'package:task/util/color_constant.dart';
import 'package:task/util/strings.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<List<ResponseModel>>? futureData;
  @override
  void initState() {
    super.initState();
    futureData = DioApiService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    'User Details',
                    style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            FutureBuilder<List<ResponseModel>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<ResponseModel> userList = snapshot.data ?? [];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    ResponseModel data = userList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorConstant.lightGrey8391A1, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        tileColor: ColorConstant.lightGrey,
                        title: Text(
                          data.name,
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        subtitle: Text(
                          data.email,
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        leading: Text(
                          data.gender.toString(),
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: InkWell(
                                    onTap: () {
                                      int deleteId2 = data.id;
                                      setState(() {
                                        if (deleteId2 == data.id) {
                                          DeleteApi.deleteData(id: data.id);
                                          futureData = DioApiService.getData();
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: const Text(
                                                        'User Deleted'),
                                                    content: Text(
                                                        'name: ${data.name},id : ${data.id},email : ${data.email} is Deleted'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ));
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorConstant.black,
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: InkWell(
                                    onTap: () {
                                      IdConstant.getId = data.id;
                                      Strings.stringEmail = data.email;
                                      Strings.stringName = data.name;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateScreen(),
                                          ));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: ColorConstant.black,
                                    )))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
