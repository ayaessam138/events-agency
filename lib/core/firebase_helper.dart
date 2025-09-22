import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument({
    required String collection,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    try {
      if (docId != null) {
        await _firestore.collection(collection).doc(docId).set(data);
      } else {
        await _firestore.collection(collection).add(data);
      }
    } catch (e) {
      throw Exception('فشل في إضافة المستند: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentByField({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      final snapshot =
          await _firestore
              .collection(collection)
              .where(field, isEqualTo: value)
              .get();

      if (snapshot.docs.isEmpty) {
        throw Exception("المستند غير موجود");
      }

      // خد أول document
      return snapshot.docs.first;
    } catch (e) {
      throw Exception('فشل في جلب المستند: $e');
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllDocuments({
    required String collection,
  }) async {
    try {
      final snapshot = await _firestore.collection(collection).get();
      return snapshot.docs;
    } catch (e) {
      throw Exception('فشل في جلب البيانات: $e');
    }
  }

  Future<void> updateDocument({
    required String collection,
    String? docId, // اختياري
    String? field, // اختياري
    dynamic value, // اختياري
    required Map<String, dynamic> data,
  }) async {
    try {
      if (docId != null) {
        // ✅ update بالـ docId
        await _firestore.collection(collection).doc(docId).update(data);
      } else if (field != null && value != null) {
        // ✅ update بالشرط
        final snapshot =
            await _firestore
                .collection(collection)
                .where(field, isEqualTo: value)
                .get();

        if (snapshot.docs.isEmpty) {
          throw Exception("لا يوجد مستند يطابق الشرط");
        }

        final targetDocId = snapshot.docs.first.id;
        await _firestore.collection(collection).doc(targetDocId).update(data);
      } else {
        throw Exception("لازم تحدد docId أو شرط (field + value)");
      }
    } catch (e) {
      throw Exception('فشل في تحديث المستند: $e');
    }
  }

  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw Exception('فشل في حذف المستند: $e');
    }
  }
}
