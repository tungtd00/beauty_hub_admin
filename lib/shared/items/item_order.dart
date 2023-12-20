import 'package:beauty_hub_admin/models/order.dart';
import 'package:beauty_hub_admin/shared/items/item_order_item.dart';
import 'package:flutter/material.dart';

import '../../models/order_item.dart';

class ItemOrder extends StatefulWidget {
  final Order order;

  const ItemOrder({super.key, required this.order});

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  List<OrderItem> orderItems = [];

  @override
  void initState() {
    orderItems = widget.order.orderItems;
    super.initState();
  }

  void getUserInfo() {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.order.idOrder,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade500,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              ItemOrderItem(item: orderItems[index]),
          itemCount: orderItems.length,
        ),
      ],
    );
  }
}
