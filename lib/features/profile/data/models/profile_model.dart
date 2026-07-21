import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.uid,
    required super.name,
    required super.email,
    super.imageUrl,
    required super.isGuest,
    required super.chats,
    required super.readmes,
    required super.analysis,
  });

  factory ProfileModel.fromFirebase({
    required String uid,
    required String name,
    required String email,
    String? imageUrl,
    required bool isGuest,
    required int chats,
  }) {
    return ProfileModel(
      uid: uid,
      name: name,
      email: email,
      imageUrl: imageUrl,
      isGuest: isGuest,
      chats: chats,
      readmes: chats > 0 ? (chats ~/ 3) + 1 : 0,
      analysis: chats > 0 ? chats ~/ 4 : 0,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      isGuest: json['isGuest'],
      chats: json['chats'],
      readmes: json['readmes'],
      analysis: json['analysis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'isGuest': isGuest,
      'chats': chats,
      'readmes': readmes,
      'analysis': analysis,
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      uid: uid,
      name: name,
      email: email,
      imageUrl: imageUrl,
      isGuest: isGuest,
      chats: chats,
      readmes: readmes,
      analysis: analysis,
    );
  }
}
