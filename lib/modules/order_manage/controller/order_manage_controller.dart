import 'package:beauty_hub_admin/models/order.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:get/get.dart';

class OrderManageController extends GetxController {
  RxList<Order> orders = RxList<Order>();

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  @override
  void onReady() {
    getOrders();
    super.onReady();
  }

  Future<void> getOrders() async {
    FirebaseService.fetchOrders((dataList) {
      orders.value = dataList;
    });
  }
}
