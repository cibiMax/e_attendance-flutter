import 'package:e_attendance/core/constants/image_constants.dart';
import 'package:e_attendance/presentation/widgets/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart' show AppColors;
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () => Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.accentColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: CustomAssetImage(path: ImageConstants.loginCover),
                ),
              ),

              // Main content
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                   CustomAssetImage(
                     path:ImageConstants.loginCover,
                     
                    ),
                    const SizedBox(height: 40),

                    // Loading indicator
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 20),

                    // Status text
                    Text(
                      controller.isConnected.value
                          ? "Checking user..."
                          : "No internet connection",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
