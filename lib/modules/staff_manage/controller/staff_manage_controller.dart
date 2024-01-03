import 'dart:developer';
import 'package:get/get.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';

class StaffManageController extends GetxController {
   RxList<UserAdmin> userAdminList = RxList<UserAdmin>();
    RxBool isLoading = RxBool(true);

  @override
  void onInit() {
    getUserAdmin();
  
    super.onInit();
  }

  Future<void> getUserAdmin() async {
    FirebaseService.fetchUserAdmin((dataList) {
      isLoading.value = false;
      userAdminList.value = dataList;
    }, (error) {
      log('Error: $error');
      EasyLoading.showError('Đã có lỗi xảy ra');
    });
  }

  void onAddUserAdmin() {
    Get.toNamed(AppRoutes.addUserAdmin);
  }

  void onEditUserAdmin(UserAdmin userAdmin) {
    Get.toNamed(AppRoutes.addUserAdmin, arguments: userAdmin);
  }
  Future<void> onRemoveUser(String id) async {
   await FirebaseService.deleteUserAdmin(id);
     Get.offAllNamed(AppRoutes.staffManage);
  }
}
