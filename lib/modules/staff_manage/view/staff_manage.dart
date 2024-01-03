import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/shared/utils/app_color.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:beauty_hub_admin/shared/items/item_account.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:beauty_hub_admin/modules/staff_manage/controller/staff_manage_controller.dart';

class StaffManage extends GetView<StaffManageController> {
  const StaffManage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
           leading: IconButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.homePage);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              ),
            ),
          title: const Text(
            'Danh sách tài khoản',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  controller.onAddUserAdmin();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.userAdminList.isNotEmpty
                      ? Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: ListView.separated(
                            itemBuilder: ((context, index) => ItemAccount(
                                  email: controller.userAdminList[index].email,
                                  fullName:
                                      controller.userAdminList[index].fullName,
                                  index: index,
                                  role: controller.userAdminList[index].role,
                                  sex: controller.userAdminList[index].sex,
                                  id: controller.userAdminList[index].idAccount,
                                  birthDay:DateFormat('dd/MM/yyyy').format(controller.userAdminList[index].birthDay), 
                                  editAccount: (String id) {
                                    controller.onEditUserAdmin(controller.userAdminList[index]);
                                    
                                  },
                                  removeAccount: (String id) {
                                    controller.onRemoveUser(id);
                                  },
                                )),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: controller.userAdminList.length,
                                                  ),
                          ))
                      : const Center(child: Text('Danh sách nhân viên trống')),
            
          ],
        ),
      ),
    );
  }
}
