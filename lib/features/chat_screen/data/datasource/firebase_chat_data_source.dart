import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseChatDataSource {
  final FirebaseFirestore firestore;

  FirebaseChatDataSource({required this.firestore});
  Future <void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
  })async{
    final uid=FirebaseAuth.instance.currentUser!.uid;
    await firestore.collection('user').doc(uid).collection('conversations').doc(chatId).collection('messages')
        .add({
          "text": text,
          "isUser": isUser,
          "createdAt": FieldValue.serverTimestamp(),
        });

        await firestore
        .collection("user")
        .doc(uid)//uid
        .collection("conversations")
        .doc(chatId)
        .set({
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
  Future<List<Map<String, dynamic>>> loadMessages(String chatId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await firestore
        .collection("user")
        .doc(uid)
        .collection("conversations")
        .doc(chatId)
        .collection("messages")
        .orderBy("createdAt")
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }
  Future<String> createConversation() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = firestore
        .collection("user")
        .doc(uid)
        .collection("conversations")
        .doc();

    await ref.set({
      "title": "",
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    return ref.id;
  }
}