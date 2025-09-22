import 'package:bookingapp/core/error_handle/failure.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/events/data/data_source/local/firebase_events_local.dart';
import 'package:bookingapp/firebase/events/data/data_source/remote/firebase_events_remote.dart';

import 'package:dartz/dartz.dart';

abstract class FirebaseEventsHomeRepo {
  Future<Either<Failure, List<FirebaseEventsModel>>> getEvents({
    bool isRefresh = false,
  });
  Future<Either<Failure, FirebaseEventsModel>> getEventDeatils({
    required String eventId,
  });
}

class FirebaseEventsRepoImpl implements FirebaseEventsHomeRepo {
  final FirebaseEventsRemote remote;
  final FirebaseEventsLocal local;

  FirebaseEventsRepoImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, List<FirebaseEventsModel>>> getEvents({
    bool isRefresh = false,
  }) async {
    try {
      if (isRefresh) {
        await local.clearCache();
      }

      final cached = await local.getCachedEvents();

      if (!isRefresh && cached.isNotEmpty) {
        return Right(cached);
      }

      final events = await remote.getEvents();

      await local.cacheEvents(events);

      return Right(events);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: "Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, FirebaseEventsModel>> getEventDeatils({
    required String eventId,
  }) async {
    try {
      final event = await remote.getEventDeatils(eventId: eventId);
      return Right(event);
    } catch (e) {
      print("events error");
      print(e.toString());
      return Left(Failure(message: "Unexpected error: $e"));
    }
  }
}
