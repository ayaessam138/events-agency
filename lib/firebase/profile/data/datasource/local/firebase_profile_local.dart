import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:hive/hive.dart';

abstract class FirebaseProfileLocal {
  Future<FirebaseProfileModel?> getUserProfile();
  Future<void> cacheUserProfile(FirebaseProfileModel profile);
  Future<void> clearCache();
}

class FirebaseProfileLocalImpl implements FirebaseProfileLocal {
  final Box<FirebaseProfileModel> box;

  FirebaseProfileLocalImpl({required this.box});

  @override
  Future<FirebaseProfileModel?> getUserProfile() async {
    return box.get(AppSavedKey.profile);
  }

  @override
  Future<void> cacheUserProfile(FirebaseProfileModel profile) async {
    await box.put(AppSavedKey.profile, profile);
  }

  @override
  Future<void> clearCache() async {
    await box.clear();
    print("hiveBox.length");
    print(box.length);
  }
}
