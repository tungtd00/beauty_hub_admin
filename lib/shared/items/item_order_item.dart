import 'package:beauty_hub_admin/models/order_item.dart';
import 'package:flutter/material.dart';

class ItemOrderItem extends StatefulWidget {
  final OrderItem item;
  const ItemOrderItem({super.key, required this.item});

  @override
  State<ItemOrderItem> createState() => _ItemOrderItemState();
}

class _ItemOrderItemState extends State<ItemOrderItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
