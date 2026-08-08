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

    int chatsCount = 0;
    int readmesCount = 0;
    int analysisCount = 0;
    int debugCount = 0;
    int explainCount = 0;
    int plannerCount = 0;

    try {
      final conversationsSnapshot = await firestore
          .collection('user')
          .doc(user.uid)
          .collection('conversations')
          .get();

      for (var doc in conversationsSnapshot.docs) {
        final data = doc.data();
        final type = (data['type'] ?? '').toString().toLowerCase();

        if (type.contains('chat')) {
          chatsCount++;
        } else if (type.contains('readme')) {
          readmesCount++;
        } else if (type.contains('review') || type.contains('analysis')) {
          analysisCount++;
        } else if (type.contains('debug')) {
          debugCount++;
        } else if (type.contains('explain')) {
          explainCount++;
        } else if (type.contains('planner')) {
          plannerCount++;
        }
      }
    } catch (e) {
      throw Exception('فشل في جلب الإحصائيات: $e');
    }

    return ProfileModel.fromFirebase(
      uid: user.uid,
      name: user.displayName ?? 'Guest',
      email: user.email ?? '',
      imageUrl: user.photoURL,
      isGuest: user.isAnonymous,
      chats: chatsCount,
      readmes: readmesCount,
      analysis: analysisCount,
      debug: debugCount,
      explain: explainCount,
      planner: plannerCount,
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
  Future<void> deletePhoto() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل الدخول');

    try {
      await user.updatePhotoURL(null);
    } catch (e) {
      throw Exception('فشل في حذف الصورة: $e');
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
      // 1. Delete the conversations subcollection (in chunks of 500)
      final conversationsSnapshot = await firestore
          .collection('user')
          .doc(user.uid)
          .collection('conversations')
          .get();

      final docs = conversationsSnapshot.docs;
      for (var i = 0; i < docs.length; i += 500) {
        final batch = firestore.batch();
        for (var doc in docs.skip(i).take(500)) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }

      // 2. Delete the user document itself
      await firestore.collection('user').doc(user.uid).delete();

      // 3. Delete the Firebase Auth account (must be LAST)
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'Please re-authenticate (logout & login) before deleting your account.',
        );
      }
      throw Exception(e.message ?? 'Failed to delete account.');
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  @override
  Future<void> updateProfileDetails(String name) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      await user.updateDisplayName(name);

      // ✅ unified to 'user' (was 'users')
      await firestore.collection('user').doc(user.uid).set({
        'name': name,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
