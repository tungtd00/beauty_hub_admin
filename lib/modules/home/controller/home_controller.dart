import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beauty_hub_admin/shared/utils/app_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';


class HomeController extends GetxController {
 
   static final _prefs = Get.find<SharedPreferences>();
   String? a = null;
  RxnBool isStoreExists = RxnBool(null);
  static final _auth = FirebaseAuth.instance;
  static final _database = FirebaseDatabase.instance;
  static final _storage = FirebaseStorage.instance;

  static final _dbRef = _database.refFromURL(AppConstants.dbUrl);
  static final _storeRef = _storage.refFromURL(AppConstants.stoRef);


  void onCreateStore() {
    AppUtils.showCreateStoreBottomSheet(() {
      checkStoreWithAccountExists();
    });
  }

  void checkStoreWithAccountExists() {
    FirebaseService.fetchBrandWithAccount((value) {
      isStoreExists.value = value;
    }, (error) => log("Error: $error"));
  }
  Future<void> onEditUserAdmin( ) async {
   UserAdmin? userAdmin;
      _dbRef.child('UserAdmin').get().then((snapshot) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final data = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          UserAdmin userAdminTest = UserAdmin.fromJson(data);
          if (userAdminTest.idAccount ==   _prefs.getString(AppConstants.idUser)) {
            userAdmin = userAdminTest;
          }
        }
        print("object : $userAdmin");
        if (userAdmin != null) {
          if (userAdmin?.idAccount != null) {
            Get.toNamed(AppRoutes.addUserAdmin, arguments: userAdmin);
            // _prefs.setString(AppConstants.idUser, userAdmin?.idAccount ?? "");
            // Get.offAllNamed(AppRoutes.homePage,arguments:userAdmin );
          }
        }
      });
    
  }

  void onLogOutWithAdmin() {
    FirebaseService.signOut(() {
      Get.offAllNamed(AppRoutes.authPage);
      _prefs.setString(AppConstants.idUser, "");
    }, (error) => EasyLoading.showError(error));
    
  }
}
