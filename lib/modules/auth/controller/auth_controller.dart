import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static final _prefs = Get.find<SharedPreferences>();
  static final _dbRef = _database.refFromURL(AppConstants.dbUrl);
  static final _database = FirebaseDatabase.instance;
  Future<void> onLogin() async {
    if (globalKey.currentState!.validate()) {
      UserAdmin? userAdmin;
      _dbRef.child('UserAdmin').get().then((snapshot) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final data = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          UserAdmin userAdminTest = UserAdmin.fromJson(data);
          if (userAdminTest.email == emailController.text &&
              userAdminTest.password == passwordController.text) {
            userAdmin = userAdminTest;
          }
        }
        print("object : $userAdmin");
        if (userAdmin != null) {
          if (userAdmin?.idAccount != null) {
            _prefs.setString(AppConstants.idUser, userAdmin?.idAccount ?? "");
            Get.offAllNamed(AppRoutes.homePage,arguments:userAdmin );
          }
        }
      });
    }
  }

   Future<UserAdmin?> getUser(String id) async {
      UserAdmin? userAdmin;
     await _dbRef.child('UserAdmin').get().then((snapshot) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final data = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          UserAdmin userAdminTest = UserAdmin.fromJson(data);
          if (userAdminTest.idAccount == id) {
            return userAdminTest;
          }
        }
        return null;
       
      });
    
  }
}
