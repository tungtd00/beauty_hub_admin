import 'package:beauty_hub_admin/modules/revenue_statistics/controller/revenue_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueStatisticsPage extends GetView<RevenueStatisticsController> {
  const RevenueStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.revenueStore.value != 0.0
                ? Center(
                    child: Text(
                      'Doanh thu: ${controller.revenueStore.value}',
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
