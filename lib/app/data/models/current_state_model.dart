import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saramitnayo/constants.dart';

class CurrentStateModel {
  bool? forceUpdate;
  bool? isLightOn;
  Timestamp? lastUpdatedAt;
  Timestamp? updateTriggeredAt;

  CurrentStateModel({this.updateTriggeredAt,this.lastUpdatedAt,this.forceUpdate,this.isLightOn});

  CurrentStateModel.fromJson(Map<String, Object?> json)
      : this(
      forceUpdate: json[FirestoreConstants.forceUpdate]! as bool,
      isLightOn: json[FirestoreConstants.isLightOn]! as bool,
      lastUpdatedAt: json[FirestoreConstants.lastUpdatedAt]! as Timestamp,
      updateTriggeredAt: json[FirestoreConstants.updateTriggeredAt]! as Timestamp
    );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[FirestoreConstants.forceUpdate] = forceUpdate;
    data[FirestoreConstants.isLightOn] = isLightOn;
    data[FirestoreConstants.lastUpdatedAt] = lastUpdatedAt;
    data[FirestoreConstants.updateTriggeredAt] = updateTriggeredAt;
    return data;
  }
}