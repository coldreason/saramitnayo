import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saramitnayo/app/data/models/current_state_model.dart';
import 'package:saramitnayo/constants.dart';


class CurrentStateProvider {
  CollectionReference<CurrentStateModel> currentStateRef = FirebaseFirestore.instance
      .collection(FirestoreConstants.currentState)
      .withConverter<CurrentStateModel>(
    fromFirestore: (snapshot, _) => CurrentStateModel.fromJson(snapshot.data()!),
    toFirestore: (CurrentStateModel, _) => CurrentStateModel.toJson(),
  );


  Stream<CurrentStateModel> getStateStream()async *{
    Stream<DocumentSnapshot<CurrentStateModel>> stream =  currentStateRef.doc(FirestoreConstants.currentState).snapshots();
    CurrentStateModel emptymodel =  CurrentStateModel(forceUpdate: false,updateTriggeredAt: Timestamp.now(),lastUpdatedAt: Timestamp.now(),isLightOn: true);
    await for (var value in stream){
      yield value.data()??emptymodel;
    }
  }


  //todo : potentially rewrite current state with old data but solved within 30min
  Future<bool> enrollForcedUpdate() async {
    DocumentSnapshot<CurrentStateModel> stateDoc = await currentStateRef.doc(FirestoreConstants.currentState).get();
    CurrentStateModel state = stateDoc.data()!;
    state.forceUpdate = true;
    state.updateTriggeredAt = Timestamp.now();
    await currentStateRef.doc(FirestoreConstants.currentState).set(state);
    return true;
  }

}

