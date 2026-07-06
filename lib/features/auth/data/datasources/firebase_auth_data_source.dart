import 'package:dev_mate_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dev_mate_ai/features/auth/domain/entities/auth_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource implements AuthRemoteDataSource {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Future<bool> isAuthenticated() async{
    return _auth.currentUser!=null;
  }

  @override
  Future<AuthUserEntity?> signIn({required String email, required String password}) async{
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.sendEmailVerification();
      if (!credential.user!.emailVerified) {
        throw Exception("Please verify your email.");
      }
      final user = credential.user;
      if (user == null) return null;
      return AuthUserEntity(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception("No user found.");

        case 'wrong-password':
          throw Exception("Wrong password.");

        case 'invalid-email':
          throw Exception("Invalid email.");

        default:
          throw Exception(e.message);
      }
    }
    
  }

  @override
  Future<void> signOut()async {
    try {
      return await _auth.signOut();
    }on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception("No user found.");

        case 'wrong-password':
          throw Exception("Wrong password.");

        case 'invalid-email':
          throw Exception("Invalid email.");

        default:
          throw Exception(e.message);
      }
    }
    
  }

  @override
  Future<AuthUserEntity?> signUp({required String name, required String email, required String password})async {
    try {
     final credntial = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credntial.user?.sendEmailVerification();
      final user = credntial.user;
      if (!credntial.user!.emailVerified) {
        throw Exception("Please verify your email.");
      }
      if (user == null) return null;
      return AuthUserEntity(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception("No user found.");

        case 'wrong-password':
          throw Exception("Wrong password.");

        case 'invalid-email':
          throw Exception("Invalid email.");

        default:
          throw Exception(e.message);
      }
    }
    
  }
}