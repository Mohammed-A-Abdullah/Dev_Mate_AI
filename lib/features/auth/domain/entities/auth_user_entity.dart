class AuthUserEntity {
  final String uid;
  final String email;
  final String? displayName;
  final bool isAnonymous;

  const AuthUserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.isAnonymous = false,
  });
}
