import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/profile_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String cloudName = 'ednlfqzo';
  final String uploadPreset = 'igtrcmzy';

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
  Future<String> updatePhoto(File imageFile) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل الدخول');

    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String imageUrl = responseData['secure_url'];

        await user.updatePhotoURL(imageUrl);

        return imageUrl;
      } else {
        throw Exception('فشل الرفع إلى Cloudinary: ${response.body}');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء رفع الصورة: $e');
    }
  }


  @override
  Future<void> changePassword(String newPassword) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User is not logged in');

    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'Please re-authenticate (logout & login) before updating your password.',
        );
      }
      throw Exception(e.message ?? 'Failed to update password.');
    }
  }

  @override
  Future<void> deleteAccount() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User is not logged in');

    try {
      final historyDocs = await firestore
          .collection('history')
          .where('uid', isEqualTo: user.uid)
          .get();

      for (var doc in historyDocs.docs) {
        await doc.reference.delete();
      }

      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'Please re-authenticate (logout & login) before deleting your account.',
        );
      }
      throw Exception(e.message ?? 'Failed to delete account.');
    }
  }
}
