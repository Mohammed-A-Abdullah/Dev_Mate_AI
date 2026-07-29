import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String buildConversationTitle(String prompt) {
  final trimmed = prompt.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (trimmed.isEmpty) return 'New Chat';

  if (trimmed.length <= 24) return trimmed;

  return '${trimmed.substring(0, 24)}...';
}

String buildQuickToolPromptSummary(String prompt, String fallbackTitle) {
  final trimmed = prompt.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (trimmed.isEmpty) return fallbackTitle;

  if (trimmed.length <= 48) return trimmed;

  return '${trimmed.substring(0, 48)}...';
}

class FirebaseChatDataSource {
  final FirebaseFirestore firestore;

  FirebaseChatDataSource({required this.firestore});

  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
    required String type,
    String? title,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');
    final uid = user.uid;
    final conversationRef = firestore
        .collection('user')
        .doc(uid)
        .collection('conversations')
        .doc(chatId);

    await conversationRef.collection('messages').add({
      'text': text,
      'isUser': isUser,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await conversationRef.set({
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessage': text,
      'type': type,
      'messageCount': FieldValue.increment(1),
      if (title != null && title.isNotEmpty) 'title': title,
    }, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> loadMessages(String chatId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await firestore
        .collection('user')
        .doc(uid)
        .collection('conversations')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<String> saveQuickToolConversation({
    required String title,
    required String type,
    required String prompt,
    required String response,
  }) async {
    final chatTitle = buildQuickToolPromptSummary(prompt, title);
    final chatId = await createConversation(title: chatTitle, type: type);

    await saveMessage(
      chatId: chatId,
      text: prompt,
      isUser: true,
      type: type,
      title: chatTitle,
    );
    await saveMessage(
      chatId: chatId,
      text: response,
      isUser: false,
      type: type,
      title: chatTitle,
    );

    return chatId;
  }

  Future<String> createConversation({
    required String title,
    required String type,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = firestore
        .collection('user')
        .doc(uid)
        .collection('conversations')
        .doc();

    await ref.set({
      'title': title,
      'type': type,
      'lastMessage': '',
      'messageCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return ref.id;
  }
}
