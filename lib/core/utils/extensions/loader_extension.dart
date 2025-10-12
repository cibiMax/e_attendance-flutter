import 'package:e_attendance/presentation/widgets/loader_widget.dart';
import 'package:get/get.dart';

extension Loaders on GetInterface {
  void showLoadingDialog() {
    Get.dialog(LoaderWidget());
  }

  /// Close loading
  void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
