import 'package:bookingapp/core/firebase_helper.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';


abstract class FirebaseOrganizerRemote {
 
  Future<FirebaseOrganizerModel> getorganizeriDeatils({required String organizerid});
}

class FirebaseOrganizerRemoteImpl implements FirebaseOrganizerRemote {
  final FirestoreService firestoreService;

  FirebaseOrganizerRemoteImpl({required this.firestoreService});

 
  @override
  Future<FirebaseOrganizerModel> getorganizeriDeatils({required String organizerid}) async {
    final doc = await firestoreService.getDocumentByField(
      collection: FirebaseCollections.organizerCollection,
      field: "id",
      value: organizerid,
    );

    // doc.data() => Map<String, dynamic>?
    final data = doc.data();
    if (data == null) {
      throw Exception("Event not found with id $organizerid");
    }
    //Map<String, dynamic>?=>FirebaseOrganizerModel
    return FirebaseOrganizerModel.fromMap(data,id: doc.id);
  }
}
