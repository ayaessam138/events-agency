// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_events_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirebaseEventsModelAdapter extends TypeAdapter<FirebaseEventsModel> {
  @override
  final int typeId = 3;

  @override
  FirebaseEventsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirebaseEventsModel(
      eventId: fields[0] as String,
      picture: fields[1] as String,
      date: fields[2] as String,
      title: fields[3] as String,
      address: fields[4] as String,
      numberOfGoing: fields[5] as int,
      organizer: fields[6] as FirebaseOrganizerModel,
      aboutEvent: fields[7] as String?,
      eventPrice: fields[8] as String?,
      addressTitle: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FirebaseEventsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.eventId)
      ..writeByte(1)
      ..write(obj.picture)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.numberOfGoing)
      ..writeByte(6)
      ..write(obj.organizer)
      ..writeByte(7)
      ..write(obj.aboutEvent)
      ..writeByte(8)
      ..write(obj.eventPrice)
      ..writeByte(9)
      ..write(obj.addressTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirebaseEventsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FirebaseOrganizerModelAdapter
    extends TypeAdapter<FirebaseOrganizerModel> {
  @override
  final int typeId = 4;

  @override
  FirebaseOrganizerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirebaseOrganizerModel(
      id: fields[0] as String,
      name: fields[1] as String,
      picture: fields[2] as String,
      numberOfFollowing: fields[3] as int?,
      numberOfFollowers: fields[4] as int?,
      about: fields[5] as String?,
      events: (fields[6] as List?)?.cast<FirebaseEventsModel>(),
      reviews: (fields[7] as List?)?.cast<FirebaseReviewsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FirebaseOrganizerModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.picture)
      ..writeByte(3)
      ..write(obj.numberOfFollowing)
      ..writeByte(4)
      ..write(obj.numberOfFollowers)
      ..writeByte(5)
      ..write(obj.about)
      ..writeByte(6)
      ..write(obj.events)
      ..writeByte(7)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirebaseOrganizerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FirebaseReviewsModelAdapter extends TypeAdapter<FirebaseReviewsModel> {
  @override
  final int typeId = 5;

  @override
  FirebaseReviewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirebaseReviewsModel(
      reviewId: fields[0] as String,
      reviewerPicture: fields[1] as String?,
      reviewerName: fields[2] as String?,
      rate: fields[3] as int?,
      review: fields[4] as String?,
      reviewDate: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FirebaseReviewsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.reviewId)
      ..writeByte(1)
      ..write(obj.reviewerPicture)
      ..writeByte(2)
      ..write(obj.reviewerName)
      ..writeByte(3)
      ..write(obj.rate)
      ..writeByte(4)
      ..write(obj.review)
      ..writeByte(5)
      ..write(obj.reviewDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirebaseReviewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
