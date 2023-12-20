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

  Future<void> getOrders() async {
    orders.value = await FirebaseService.fetchOrders();
  }
}