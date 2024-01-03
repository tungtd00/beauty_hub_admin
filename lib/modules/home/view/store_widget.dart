import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/services/firebase_service.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';



class StoreWidget extends StatefulWidget {
  final bool? isExists;
  final Function() onCreate;
  final Function() onLogOut;
  final UserAdmin userAdmin;

  const StoreWidget({
    super.key,
    required this.onLogOut,
    required this.onCreate,
    this.isExists,
    required this.userAdmin
  });

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  bool isLoading = true;
  bool isStoreExists = false;

  @override
  void initState() {
    if (widget.isExists == null) {
      checkStoreWithAccountExists();
    } else {
      isStoreExists = widget.isExists ?? false;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StoreWidget oldWidget) {
    if (oldWidget.isExists != widget.isExists) {
      setState(() {
        isStoreExists = widget.isExists ?? false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()):
             Column(

              children: [
                Visibility(
                  visible: widget.userAdmin.role == "1",
                  child:ListTile(
                      leading: const Icon(Icons.article_outlined),
                      title: const Text('Quản lý nhân viên'),
                      onTap: () {
                        Get.toNamed(AppRoutes.staffManage);
                      },
                    ),),
                    ListTile(
                      leading: const Icon(Icons.article_outlined),
                      title: const Text('Quản lý sản phẩm'),
                      onTap: () {
                        Get.toNamed(AppRoutes.productManagePage);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.event),
                      title: const Text('Quản lý đơn hàng'),
                      onTap: () {
                        Get.toNamed(AppRoutes.orderManagePage);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text('Doanh thu của cửa hàng'),
                      onTap: () {
                        Get.toNamed(AppRoutes.revenueStatisticsPage);
                      },
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () {
                        widget.onLogOut();
                      },
                      minWidth: Get.width,
                      height: 48.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      color: Colors.grey.shade100,
                      elevation: 0.0,
                      disabledElevation: 0.0,
                      child: const Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ]));
              
  }

  void checkStoreWithAccountExists() {
    FirebaseService.fetchBrandWithAccount((value) {
      setState(() {
        isLoading = false;
        isStoreExists = value;
      });
    }, (error) => log("Error: $error"));
  }
}
