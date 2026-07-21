import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<ProfileModel> getProfile() async {
    final user = auth.currentUser!;

    final history = await firestore
        .collection('history')
        .where('uid', isEqualTo: user.uid)
        .get();

    return ProfileModel.fromFirebase(
      uid: user.uid,
      name: user.displayName ?? 'Guest',
      email: user.email ?? '',
      imageUrl: user.photoURL,
      isGuest: user.isAnonymous,
      chats: history.docs.length,
    );
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }
  
  @override
  Future<void> updatePhoto() {
    // TODO: implement updatePhoto
    throw UnimplementedError();
  }
}
