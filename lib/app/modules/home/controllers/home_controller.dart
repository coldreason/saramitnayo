import 'package:get/get.dart';
import 'package:saramitnayo/app/data/models/current_state_model.dart';
import 'package:saramitnayo/app/data/repositories/home_repository.dart';

class HomeController extends GetxController {

  final HomeRepository repository;
  bool loading = true;
  late final Stream<CurrentStateModel> currentStateStream;
  final Rx<CurrentStateModel> currentState = CurrentStateModel(lastUpdatedAt: null).obs;
  HomeController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() async{
    super.onInit();
    currentStateStream = repository.getStateStream();
    currentStateStream.listen((event) {
      currentState.value = event;
      loading = false;
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {}

  Future<bool> forceUpdate() async => await repository.enrollForcedUpdate();
}
