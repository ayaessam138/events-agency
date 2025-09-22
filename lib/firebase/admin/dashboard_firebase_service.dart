import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDashBoardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// إضافة حدث جديد
  Future<String> addEvent(FirebaseEventsModel event) async {
    try {
      final docRef = _firestore.collection('events').doc();
      await docRef.set({
        ...event.toMap(),
        'eventId': docRef.id,
        'organizerId': event.organizer.id,
      });
      return docRef.id;
    } catch (e) {
      throw Exception("فشل في إضافة الحدث: $e");
    }
  }

  Future<String> addOrganizer(FirebaseOrganizerModel organizer) async {
    try {
      final docRef = _firestore.collection('organizers').doc();

      await docRef.set({...organizer.toMap(), 'id': docRef.id});

      return docRef.id; // ✅ نرجع الـ ID
    } catch (e) {
      throw Exception("فشل في إضافة المنظم: $e");
    }
  }

  /// إضافة مراجعة جديدة مرتبطة بحدث ومنظم
  Future<void> addReview({
    required FirebaseReviewsModel review,
    required String eventId,
    required String organizerId,
  }) async {
    try {
      final docRef = _firestore.collection('reviews').doc();

      await docRef.set({
        ...review.toMap(),
        'reviewId': docRef.id, // نخزن ID
        'eventId': eventId, // ربط بالـ event
        'organizerId': organizerId, // ربط بالـ organizer
      });
    } catch (e) {
      throw Exception("فشل في إضافة المراجعة: $e");
    }
  }
}
