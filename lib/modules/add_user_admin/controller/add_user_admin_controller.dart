import 'dart:io';
import 'dart:core';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:beauty_hub_admin/shared/utils/generate_id.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';

class AddUserAdminController extends GetxController {
  final userAdminController = Get.arguments as UserAdmin?;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  RxString title = RxString("");
  RxBool isAccept = RxBool(false);
  RxString sex = RxString("1");
  RxString role = RxString("1");
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxString? error;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
   static final _prefs = Get.find<SharedPreferences>();
  @override
  void onInit() {
    if (userAdminController == null) {
      title.value = 'Tạo tài khoản quản trị';
    } else {
      title.value = 'Sửa tài khoản';
      _fillUserAdminData();
    }
    super.onInit();
  }
   void _fillUserAdminData() {
    fullNameController.text = userAdminController!.fullName;
    passwordController.text = userAdminController!.password;
    emailController.text = userAdminController!.email;
    birthDayController.text = DateFormat('dd/MM/yyyy').format(userAdminController!.birthDay);
    addressController.text = userAdminController!.address;
    sex.value = userAdminController!.sex;
    role.value = userAdminController!.role;
  }

  void showDatePickerDialog() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              title: Text('Chọn Ngày'),
              onTap: () => Get.back(),
            ),
            Container(
              child: CalendarDatePicker(
                initialDate: dateTime.value,
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
                onDateChanged: (DateTime newDate) {
                  dateTime.value = newDate;
                  birthDayController.text =
                      DateFormat('dd/MM/yyyy').format(newDate);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateSex(String value) {
    sex.value = value;
  }

  void updateRole(String value) {
    role.value = value;
  }
  Future<void> updateAccount() async {
   
     if (globalKey.currentState!.validate()) {
    UserAdmin userAdmin = UserAdmin(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      address: addressController.text,
      birthDay: dateTime.value,
      sex: sex.value,
      idAccount: userAdminController?.idAccount ?? generateRandomId(),
      role: role.value,
    );
   await FirebaseService.updateUserAdmin(userAdmin);
    userAdmin.idAccount ==  _prefs.getString(AppConstants.idUser)  ? Get.offAllNamed(AppRoutes.homePage,): Get.offAllNamed(AppRoutes.staffManage,);

  }
    // Xử lý logic khi form hợp l
  else{
    

  }
  }

  void onConfirmAddUserAdmin() {
 if (globalKey.currentState!.validate()) {
    UserAdmin userAdmin = UserAdmin(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      address: addressController.text,
      birthDay: dateTime.value,
      sex: sex.value,
      idAccount: generateRandomId(),
      role: role.value,
    );
    FirebaseService.writeUserAdminToDb(userAdmin,() {
       EasyLoading.showSuccess('Thêm tài khoản thành công');
        Get.offNamedUntil(AppRoutes.staffManage,(route) => route.isCurrent,);
      
    }, (error) {
      log('Error: $error');
      EasyLoading.showError('Đã có lỗi xảy ra');
    },);

  }
    // Xử lý logic khi form hợp l
  else{

  }
    
  }
  }
