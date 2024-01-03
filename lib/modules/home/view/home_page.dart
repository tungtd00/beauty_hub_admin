import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:beauty_hub_admin/modules/home/view/store_widget.dart';

class HomePage extends GetView<HomeController> {

   HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<SharedPreferences>();
    final setting =  prefs.getString(AppConstants.idUser);
     
    // await AuthController().getUser(setting??"");
    // final userAmin = ModalRoute.of(context)?.settings.arguments as UserAdmin;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Beauty Hub Admin',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              controller.onEditUserAdmin();
            },
            child: CircleAvatar(
                    child: Image.asset(
            "assets/profile.png",
                    ),
                  ),
          ),
      SizedBox(width: 16,)
        ],
      ),
      body: FutureBuilder<UserAdmin?>(
      future: getUser(setting??""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị màn hình chờ
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Xử lý lỗi nếu có
          return Text('Đã xảy ra lỗi: ${snapshot.error}');
        } else if(snapshot.connectionState == ConnectionState.done) {
          // Xây dựng giao diện dựa trên giá trị trả về
          final userAdmin = snapshot.data;
          if (userAdmin != null) {
            // Giao diện khi nhận được userAdmin
            return StoreWidget(
             userAdmin: userAdmin,
            isExists: controller.isStoreExists.value,
            onLogOut: () {
              controller.onLogOutWithAdmin();
            },
            onCreate: () {
              controller.onCreateStore();
            },
          ) ;
          } else {
            // Xử lý khi không nhận được userAdmin
            return Text('Không tìm thấy thông tin người dùng!');
          }
        }
        else{
           return Text('Không tìm thấy thông tin người dùng!');

         
        }
      },
    )
        
    );
  }
}
Future<UserAdmin?> getUser(String? setting) async {
  final completer = Completer<UserAdmin?>();

  final _database = FirebaseDatabase.instance;
  final _dbRef = _database.refFromURL(AppConstants.dbUrl);
  UserAdmin? userAdmin;
  try {
    final snapshot = await _dbRef.child('UserAdmin').get();
    bool foundUser = false;
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final data = jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      UserAdmin userAdminTest = UserAdmin.fromJson(data);
      if (userAdminTest.idAccount == setting) {
        completer.complete(userAdminTest);
        foundUser = true;
        break;
      }
    }

    if (!foundUser) {
      completer.complete(userAdmin);
    }
  } catch (error) {
    completer.completeError(error);
  }

  return completer.future;
}