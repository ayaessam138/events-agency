import 'package:bookingapp/api/events/persentation/screens/saved_events_screen.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/api/events/domain/entity/events_entity.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppHiveLocalStorage {
  static Future<void> init() async {
    await Hive.initFlutter();
    //cash api request
    await Hive.openBox(AppSavedKey.globalBox);
    //cashing intialroute
    await Hive.openBox(AppSavedKey.intialRoute);
    await Hive.openBox(AppSavedKey.userLOgin);

    await Hive.openBox<EventsEntity>(AppSavedKey.savedEvents);

    Hive.registerAdapter(EventsEntityAdapter());
    Hive.registerAdapter(OrganizerEntityAdapter());
    Hive.registerAdapter(FirebaseProfileModelAdapter());
    Hive.registerAdapter(FirebaseEventsModelAdapter());
    Hive.registerAdapter(FirebaseOrganizerModelAdapter());
    Hive.registerAdapter(FirebaseReviewsModelAdapter());
    //
    final profileBox = await Hive.openBox<FirebaseProfileModel>(
      AppSavedKey.profile,
    );
    getIt.registerLazySingleton<Box<FirebaseProfileModel>>(() => profileBox);
    //
    final savedEvents = await Hive.openBox<FirebaseEventsModel>(
      AppSavedKey.firebasesavedEvents,
    );
    getIt.registerLazySingleton<Box<FirebaseEventsModel>>(() => savedEvents);
  }

  static Future<void> clear(Box box) async {
    await box.clear();
  }

  //! Save & Get Bool

  static Future<void> saveBool(String key, bool value, Box box) async {
    await box.put(key, value);
  }

  static bool getBool(String key, Box box) {
    var value = box.get(key);
    return value is bool ? value : false;
  }

  //! Save & Get Int

  static Future<void> saveInt(String key, int value, Box box) async {
    await box.put(key, value);
  }

  static int getInt(String key, Box box) {
    var value = box.get(key);
    return value is int ? value : -1;
  }

  //! Save & Get String
  static Future<void> saveString(String key, String value, Box box) async {
    await box.put(key, value);
  }

  static String getString(String key, Box box) {
    var value = box.get(key);
    return value is String ? value : '';
  }

  //! Delete a Key

  static Future<void> delete(String key, Box box) async {
    box.delete(key);
  }
}
