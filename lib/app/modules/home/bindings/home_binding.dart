import 'package:get/get.dart';
import 'package:saramitnayo/app/data/providers/current_state_provider.dart';
import 'package:saramitnayo/app/data/repositories/home_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(repository: HomeRepository(currentStateProvider: CurrentStateProvider())),
    );
  }
}
