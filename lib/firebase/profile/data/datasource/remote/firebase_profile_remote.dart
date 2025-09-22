import 'package:bookingapp/core/firebase_helper.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';

abstract class FirebaseProfileRemote {
  Future<FirebaseProfileModel> getUserProfile(String uid);
  Future<void> updateUserProfile({
    required FirebaseProfileModel firebaseProfileModel,
    required String currentUserId,
  });
}

class FirebaseProfileRemoteImpl implements FirebaseProfileRemote {
  final FirestoreService firestoreService;

  FirebaseProfileRemoteImpl({required this.firestoreService});
  @override
  Future<FirebaseProfileModel> getUserProfile(String uid) async {
    var user = await firestoreService.getDocumentByField(
      collection: FirebaseCollections.userCollection,
      field: "uid",
      value: uid,
    );
    return FirebaseProfileModel.fromDoc(user);
  }

  @override
  Future<void> updateUserProfile({
    required FirebaseProfileModel firebaseProfileModel,
    required String currentUserId,
  }) async {
    firestoreService.updateDocument(
      collection: FirebaseCollections.userCollection,
      data: firebaseProfileModel.toMap(),
      field: "uid",
      value: currentUserId,
    );
  }
}
