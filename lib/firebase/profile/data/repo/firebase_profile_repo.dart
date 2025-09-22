import 'package:bookingapp/core/error_handle/failure.dart';
import 'package:bookingapp/firebase/profile/data/datasource/local/firebase_profile_local.dart';
import 'package:bookingapp/firebase/profile/data/datasource/remote/firebase_profile_remote.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseProfileRepo {
  Future<Either<Failure, FirebaseProfileModel>> getUserProfile(
    String uid, {
    bool isRefresh = false,
  });

  Future<Either<Failure, void>> updateUserProfile({
    required FirebaseProfileModel firebaseProfileModel,
    required String currentUserId,
  });
}

class FirebaseProfileRepoImpl implements FirebaseProfileRepo {
  final FirebaseProfileRemote remote;
  final FirebaseProfileLocal local;

  FirebaseProfileRepoImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, FirebaseProfileModel>> getUserProfile(
    String uid, {
    bool isRefresh = false,
  }) async {
    try {
      if (isRefresh) {
        await local.clearCache();
      }

      final cached = await local.getUserProfile();
      if (!isRefresh && cached != null) {
        return Right(cached);
      }

      final user = await remote.getUserProfile(uid);

      await local.cacheUserProfile(user);

      return Right(user);
    } catch (e) {
      return Left(Failure(message: "Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required FirebaseProfileModel firebaseProfileModel,
    required String currentUserId,
  }) async {
    try {

      await remote.updateUserProfile(
        firebaseProfileModel: firebaseProfileModel,
        currentUserId: currentUserId,
      );

      // // 🔹 Update local cache
      // await local.cacheUserProfile(firebaseProfileModel);

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: "Update failed: $e"));
    }
  }
}
