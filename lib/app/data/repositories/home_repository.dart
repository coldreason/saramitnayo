import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saramitnayo/app/data/models/current_state_model.dart';
import 'package:saramitnayo/app/data/providers/current_state_provider.dart';

class HomeRepository {
  final CurrentStateProvider currentStateProvider;

  HomeRepository({required this.currentStateProvider})
      : assert(currentStateProvider != null);

  Future<bool> enrollForcedUpdate() async =>
      await currentStateProvider.enrollForcedUpdate();

  Stream<CurrentStateModel> getStateStream()  =>
      currentStateProvider.getStateStream();
}
