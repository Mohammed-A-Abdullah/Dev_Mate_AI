class ProfileEntity {
  final String uid;
  final String name;
  final String email;
  final String? imageUrl;
  final bool isGuest;

  final int chats;
  final int readmes;
  final int analysis;

  const ProfileEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.isGuest,
    required this.chats,
    required this.readmes,
    required this.analysis,
  });
}
