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
    required super.debug,
    required super.explain,
    required super.planner,
  });

  factory ProfileModel.fromFirebase({
    required String uid,
    required String name,
    required String email,
    String? imageUrl,
    required bool isGuest,
    required int chats,
    required int readmes,
    required int analysis,
    required int debug,
    required int explain,
    required int planner,
  }) {
    return ProfileModel(
      uid: uid,
      name: name,
      email: email,
      imageUrl: imageUrl,
      isGuest: isGuest,
      chats: chats,
      readmes: readmes,
      analysis: analysis,
      debug: debug,
      explain: explain,
      planner: planner,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
      isGuest: json['isGuest'] ?? false,
      chats: json['chats'] ?? json['chat'] ?? 0,
      readmes: json['readmes'] ?? json['Generate README'] ?? 0,
      analysis: json['analysis'] ?? json['Code Review'] ?? 0,
      explain: json['explain'] ?? json['Explain Code'] ?? 0,
      debug: json['debug'] ?? json['Debug'] ?? 0,
      planner: json['planner'] ?? json['Project Planner'] ?? 0,
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
      'debug': debug,
      'explain': explain,
      'planner': planner,
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
      debug: debug,
      explain: explain,
      planner: planner,
    );
  }
}
