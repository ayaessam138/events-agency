import 'package:hive/hive.dart';

part 'firebase_events_model.g.dart';

@HiveType(typeId: 3)
class FirebaseEventsModel extends HiveObject {
  @HiveField(0)
  final String eventId;

  @HiveField(1)
  final String picture;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final int numberOfGoing;

  @HiveField(6)
  final FirebaseOrganizerModel organizer;

  @HiveField(7)
  final String? aboutEvent;

  @HiveField(8)
  final String? eventPrice;

  @HiveField(9)
  final String? addressTitle;

  FirebaseEventsModel({
    required this.eventId,
    required this.picture,
    required this.date,
    required this.title,
    required this.address,
    required this.numberOfGoing,
    required this.organizer,
    this.aboutEvent,
    this.eventPrice,
    this.addressTitle,
  });

  factory FirebaseEventsModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
  }) {
    return FirebaseEventsModel(
      eventId: map['eventId'] ?? id ?? '',
      picture: map['picture'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      address: map['address'] ?? '',
      numberOfGoing: map['numberOfGoing'] ?? 0,
      organizer: map['organizer'] != null
          ? FirebaseOrganizerModel.fromMap(
              Map<String, dynamic>.from(map['organizer']),
            )
          : FirebaseOrganizerModel(id: '', name: '', picture: ''),
      aboutEvent: map['aboutEvent'],
      eventPrice: map['eventPrice'],
      addressTitle: map['addressTitle'],
    );
  }

  factory FirebaseEventsModel.fromDoc(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return data == null
        ? FirebaseEventsModel(
            eventId: doc.id,
            picture: '',
            date: '',
            title: '',
            address: '',
            numberOfGoing: 0,
            organizer: FirebaseOrganizerModel(id: '', name: '', picture: ''),
          )
        : FirebaseEventsModel.fromMap(data, id: doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'picture': picture,
      'date': date,
      'title': title,
      'address': address,
      'numberOfGoing': numberOfGoing,
      'organizer': organizer.toMap(),
      'aboutEvent': aboutEvent,
      'eventPrice': eventPrice,
      'addressTitle': addressTitle,
    };
  }
}

@HiveType(typeId: 4)
class FirebaseOrganizerModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String picture;

  @HiveField(3)
  final int? numberOfFollowing;

  @HiveField(4)
  final int? numberOfFollowers;

  @HiveField(5)
  final String? about;

  @HiveField(6)
  final List<FirebaseEventsModel>? events;

  @HiveField(7)
  final List<FirebaseReviewsModel>? reviews;

  FirebaseOrganizerModel({
    required this.id,
    required this.name,
    required this.picture,
    this.numberOfFollowing,
    this.numberOfFollowers,
    this.about,
    this.events,
    this.reviews,
  });

  factory FirebaseOrganizerModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
  }) {
    return FirebaseOrganizerModel(
      id: map['id'] ?? id ?? '',
      name: map['name'] ?? '',
      picture: map['picture'] ?? '',
      numberOfFollowing: map['numberOfFollowing'],
      numberOfFollowers: map['numberOfFollowers'],
      about: map['about'],
      events: map['events'] != null
          ? List<FirebaseEventsModel>.from(
              map['events'].map(
                (e) => FirebaseEventsModel.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              ),
            )
          : null,
      reviews: map['reviews'] != null
          ? List<FirebaseReviewsModel>.from(
              map['reviews'].map(
                (e) => FirebaseReviewsModel.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              ),
            )
          : null,
    );
  }

  factory FirebaseOrganizerModel.fromDoc(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return data == null
        ? FirebaseOrganizerModel(id: doc.id, name: '', picture: '')
        : FirebaseOrganizerModel.fromMap(data, id: doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'picture': picture,
      'numberOfFollowing': numberOfFollowing,
      'numberOfFollowers': numberOfFollowers,
      'about': about,
      'events': events?.map((e) => e.toMap()).toList(),
      'reviews': reviews?.map((r) => r.toMap()).toList(),
    };
  }
}

@HiveType(typeId: 5)
class FirebaseReviewsModel extends HiveObject {
  @HiveField(0)
  final String reviewId;

  @HiveField(1)
  final String? reviewerPicture;

  @HiveField(2)
  final String? reviewerName;

  @HiveField(3)
  final int? rate;

  @HiveField(4)
  final String? review;

  @HiveField(5)
  final String? reviewDate;

  FirebaseReviewsModel({
    required this.reviewId,
    this.reviewerPicture,
    this.reviewerName,
    this.rate,
    this.review,
    this.reviewDate,
  });

  factory FirebaseReviewsModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
  }) {
    return FirebaseReviewsModel(
      reviewId: map['reviewId'] ?? id ?? '',
      reviewerPicture: map['reviewerPicture'],
      reviewerName: map['reviewerName'],
      rate: map['rate'],
      review: map['review'],
      reviewDate: map['reviewDate'],
    );
  }

  factory FirebaseReviewsModel.fromDoc(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return data == null
        ? FirebaseReviewsModel(reviewId: doc.id)
        : FirebaseReviewsModel.fromMap(data, id: doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'reviewerPicture': reviewerPicture,
      'reviewerName': reviewerName,
      'rate': rate,
      'review': review,
      'reviewDate': reviewDate,
    };
  }
}
