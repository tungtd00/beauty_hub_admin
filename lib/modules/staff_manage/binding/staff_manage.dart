import 'package:get/get.dart';
import 'package:beauty_hub_admin/modules/staff_manage/controller/staff_manage_controller.dart';

class StaffManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StaffManageController());
  }
}