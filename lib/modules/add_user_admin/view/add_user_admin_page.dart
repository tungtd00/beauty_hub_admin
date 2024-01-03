import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:beauty_hub_admin/shared/utils/app_color.dart';
import 'package:beauty_hub_admin/shared/utils/validate_utils.dart';
import 'package:beauty_hub_admin/modules/add_user_admin/controller/add_user_admin_controller.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

class AddUserAdminPage extends GetView<AddUserAdminController> {
  AddUserAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            ),
          ),
          title: const Text(
            'Tạo tài khoản quản trị',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: controller.globalKey,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Tạo tài khoản',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextFormField(
                              controller: controller.emailController,
                              validator: (value) =>
                                  ValidateUtils.validateEmail(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Hãy nhập email',
                                hintStyle: TextStyle(fontSize: 14.0),
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controller.passwordController,
                              validator: (value) =>
                                  ValidateUtils.validatePassword(value),
                              decoration: const InputDecoration(
                                labelText: 'password',
                                hintText: 'Nhập password',
                                hintStyle: TextStyle(fontSize: 14.0),
                                prefixIcon: Icon(Icons.lock_outlined),
                                suffixIcon: Icon(Icons.visibility_outlined),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Họ tên',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextFormField(
                              controller: controller.fullNameController,
                              validator: (value) =>
                                  ValidateUtils.validateEmptyData(value),
                              decoration: const InputDecoration(
                                hintText: 'Nhập tên',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Ngày sinh',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextFormField(
                              controller: controller.birthDayController,
                              readOnly: true,
                              validator: (value) {
                                return ValidateUtils.validateEmptyData(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Nhập ngày sinh',
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    controller.showDatePickerDialog();
                                  },
                                  child: const Icon(Icons.event),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Giới tính',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.primaryAppColor),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: [
                                    const DropdownMenuItem(
                                      value: "1",
                                      child: Text('Nam'),
                                    ),
                                    const DropdownMenuItem(
                                      value: "2",
                                      child: Text('Nữ'),
                                    ),
                                    const DropdownMenuItem(
                                      value: "0",
                                      child: Text('Khác'),
                                    )
                                  ],
                                  onChanged: (value) {
                                    controller.updateSex(value ?? "1");
                                  },
                                  value: controller.sex.value,
                                ),
                              ),
                            ),
                            const Text(
                              'Vai trò',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.primaryAppColor),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: (controller.userAdminController != null &&
                                      controller.userAdminController?.role ==
                                          "2")
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        items: [
                                          const DropdownMenuItem(
                                            value: "2",
                                            child: Text('Nhân viên'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          // controller.updateRole(value??"");
                                        },
                                        value: "2",
                                      ),
                                    )
                                  : DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        items: [
                                          const DropdownMenuItem(
                                            value: "1",
                                            child: Text('Admin'),
                                          ),
                                          const DropdownMenuItem(
                                            value: "2",
                                            child: Text('Nhân viên'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          controller.updateRole(value ?? "");
                                        },
                                        value: controller.role.value,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Địa chỉ',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextFormField(
                              validator: (value) {
                                return ValidateUtils.validateEmptyData(value);
                              },
                              controller: controller.addressController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: 'Nhập địa chỉ',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
              controller.userAdminController == null
                  ? MaterialButton(
                      onPressed: () {
                        controller.onConfirmAddUserAdmin();
                      },
                      color: Colors.green,
                      minWidth: Get.width,
                      height: 48.0,
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        controller.updateAccount();
                      },
                      color: Colors.green,
                      minWidth: Get.width,
                      height: 48.0,
                      child: const Text(
                        'Cập nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
