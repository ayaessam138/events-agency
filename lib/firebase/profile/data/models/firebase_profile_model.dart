import 'package:hive/hive.dart';

part 'firebase_profile_model.g.dart'; 

@HiveType(typeId: 2 ) 
class FirebaseProfileModel {
  @HiveField(0)
  final String ?uid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  FirebaseProfileModel({
     this.uid,
    required this.name,
    required this.email,
  });


  factory FirebaseProfileModel.fromMap(Map<String, dynamic> map, String docId) {
    return FirebaseProfileModel(
      uid: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }


  factory FirebaseProfileModel.fromDoc(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return FirebaseProfileModel(uid: doc.id, name: '', email: '');
    }
    return FirebaseProfileModel.fromMap(data, doc.id);
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
