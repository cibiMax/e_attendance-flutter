import 'package:e_attendance/presentation/features/common/connectivity/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnnectivityWidget extends GetView<ConnectivityController> {
  final Widget child;
  const ConnnectivityWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.isconnected.value
                ? child
                : Center(child: Text("Check your Internet connection..")),
          ),
        ],
      ),
    );
  }
}
