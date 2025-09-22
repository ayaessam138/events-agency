import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:hive/hive.dart';

abstract class FirebaseEventsLocal {
  Future<List<FirebaseEventsModel>> getCachedEvents();
  Future<void> cacheEvents(List<FirebaseEventsModel> events);
  Future<void> clearCache();
}

class FirebaseEventsLocalImpl implements FirebaseEventsLocal {
  final Box<FirebaseEventsModel> hiveBox;

  FirebaseEventsLocalImpl({required this.hiveBox});

  @override
  Future<List<FirebaseEventsModel>> getCachedEvents() async {
    return hiveBox.values.toList();
  }

  @override
  Future<void> cacheEvents(List<FirebaseEventsModel> events) async {
    await hiveBox.clear();
    await hiveBox.addAll(events);
  }

  @override
  Future<void> clearCache() async {
    await hiveBox.clear();
    print("hiveBox.length");
     print(hiveBox.length);
  }
}
