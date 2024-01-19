import 'package:flutter/material.dart';
import 'package:task/models/response_model.dart';
import 'package:task/screens/update_screen.dart';
import 'package:task/services/dio_delete_service.dart';
import 'package:task/services/dio_get_service.dart';
import 'package:task/util/color_constant.dart';

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
                          'Name: ${data.name}',
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        subtitle: Text(
                          data.email,
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: InkWell(
                                    onTap: () async{
                                      int deleteId2 = data.id;
                                      if (deleteId2 == data.id) {
                                       await DeleteApi.deleteData(id: data.id);
                                       if(context.mounted
                                       ) {showDialog<String>(
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
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'OK'),
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ));}
                                        setState(() {
                                          futureData = DioApiService.getData();
                                        });
                                      }
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
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateScreen(
                                                    userName: data.name,
                                                    userId: data.id,
                                                    userEmail: data.email,
                                                    userGender:
                                                        data.gender.toString(),
                                                    userStatus: "active",
                                                  )));
                                      setState(() {
                                        futureData = DioApiService.getData();
                                      });
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
