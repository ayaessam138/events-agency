import 'package:bookingapp/core/error_handle/failure.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/organizer/data/service/firebase_organizer.dart';

import 'package:dartz/dartz.dart';

abstract class FirebaseOrganizerRepo {
  Future<Either<Failure, FirebaseOrganizerModel>> getOrganizerDeatils({
    required String organizerId,
  });
}

class FirebaseOrgaizerRepoImpl implements FirebaseOrganizerRepo {
  final FirebaseOrganizerRemote firebaseOrganizerRemote;

  FirebaseOrgaizerRepoImpl({required this.firebaseOrganizerRemote});

  @override
  Future<Either<Failure, FirebaseOrganizerModel>> getOrganizerDeatils({
    required String organizerId,
  }) async {
    try {
      final organizer = await firebaseOrganizerRemote.getorganizeriDeatils(
        organizerid: organizerId,
      );
      return Right(organizer);
    } catch (e) {
      print("Organizer error");
      print(e.toString());
      return Left(Failure(message: "Unexpected error: $e"));
    }
  }
}
