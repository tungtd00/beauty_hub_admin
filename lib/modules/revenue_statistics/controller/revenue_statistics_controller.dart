import 'package:beauty_hub_admin/models/order_item.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:get/get.dart';

import '../../../models/order.dart';

class RevenueStatisticsController extends GetxController {
  RxDouble revenueStore = RxDouble(0.0);
  RxList<Order> orderList = RxList<Order>();

  @override
  void onInit() {
    getRevenueStore();
    super.onInit();
  }

  Future<void> getRevenueStore() async {
    orderList.value = await FirebaseService.fetchOrders();
    orderList.value =
        orderList.where((item) => item.status == 'SUCCESS').toList();
    List<OrderItem> orderItems = [];
    for (var element in orderList) {
      orderItems.addAll(element.orderItems);
    }
    for (var e in orderItems) {
      revenueStore.value = revenueStore.value + e.pricePerItem * e.quantity;
    }
  }
}
