import 'package:beauty_hub_admin/modules/order_manage/controller/order_manage_controller.dart';
import 'package:beauty_hub_admin/shared/items/item_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderManagePage extends GetView<OrderManageController> {
  const OrderManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Quản lý đơn hàng',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => controller.orders.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ItemOrder(order: controller.orders[index]),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: controller.orders.length,
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
