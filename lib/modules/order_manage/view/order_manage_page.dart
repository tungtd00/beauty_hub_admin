import 'package:beauty_hub_admin/modules/order_manage/controller/order_manage_controller.dart';
import 'package:beauty_hub_admin/shared/items/item_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderManagePage extends GetView<OrderManageController> {
  const OrderManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.separated(
            itemBuilder: (context, index) => ItemOrder(order: controller.orders[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.orders.length,
          )
        ],
      ),
    );
  }
}
