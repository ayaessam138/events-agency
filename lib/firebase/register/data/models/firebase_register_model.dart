import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseRegisterModel {
  final String? uid;
  final String name;
  final String email;
  final DateTime createdAt;

  FireBaseRegisterModel({
     this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  // Convert from Firestore to UserModel
  factory FireBaseRegisterModel.fromJson(Map<String, dynamic> map) {
    return FireBaseRegisterModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',

      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert from Firestore DocumentSnapshot to UserModel
  factory FireBaseRegisterModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FireBaseRegisterModel.fromJson(data);
  }

  // Convert UserModel to Map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
