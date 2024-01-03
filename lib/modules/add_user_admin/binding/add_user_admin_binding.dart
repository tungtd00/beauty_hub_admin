import 'package:get/get.dart';
import 'package:beauty_hub_admin/modules/add_user_admin/controller/add_user_admin_controller.dart';

class AddUserAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUserAdminController());
  }
}