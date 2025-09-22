import 'package:bookingapp/core/firebase_helper.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';

abstract class FirebaseEventsRemote {
  Future<List<FirebaseEventsModel>> getEvents();
  Future<FirebaseEventsModel> getEventDeatils({required String eventId});
}

class FirebaseEventsRemoteImpl implements FirebaseEventsRemote {
  final FirestoreService firestoreService;

  FirebaseEventsRemoteImpl({required this.firestoreService});

  @override
  Future<List<FirebaseEventsModel>> getEvents() async {
    final documents = await firestoreService.getAllDocuments(
      collection: FirebaseCollections.eventsCollection,
    );

    return documents.map((doc) {
      final data = doc.data();
      return FirebaseEventsModel.fromMap(data, id:doc.id);
    }).toList();
  }

  @override
  Future<FirebaseEventsModel> getEventDeatils({required String eventId}) async {
    final doc = await firestoreService.getDocumentByField(
      collection: FirebaseCollections.eventsCollection,
      field: "eventId",
      value: eventId,
    );

    // doc.data() => Map<String, dynamic>?
    final data = doc.data();
    if (data == null) {
      throw Exception("Event not found with id $eventId");
    }
    //Map<String, dynamic>?=>FirebaseEventsModel
    return FirebaseEventsModel.fromMap(data, id:doc.id);
  }
}
