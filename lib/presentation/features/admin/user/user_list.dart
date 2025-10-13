import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/presentation/features/admin/user/user_list_controller.dart';
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_icons.dart';

class UserList extends GetView<UserListController> {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer( key: Key("UserList")),
      appBar: CustomAppBar(title: StringConstants.users,actionBtn: [  IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: AppIcons.logout,
          ),],),
      body: ResponsiveLayout(
        child: Expanded(
          child: Obx(() {
            if (controller.isloading.value) {
              return const Center(child: CircularProgressIndicator());
            }
          
            if (controller.err.isNotEmpty) {
              return Center(child: Text(controller.err.value));
            }
          
            if (controller.list.isEmpty) {
              return const Center(child: Text("No users found"));
            }
          
            return ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                final user = controller.list[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        user.email.isNotEmpty ? user.email[0].toUpperCase() : "?",
                        style: AppTextStyles.heading,
                      ),
                    ),
                    title: Text(user.email),
                    subtitle: Text(user.departmentKey ?? "No Department"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      controller.toClockingHistory(user.userKey!);
                    },
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
