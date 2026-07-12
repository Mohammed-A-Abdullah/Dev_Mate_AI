import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.title,
    required super.lastMessage,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
    required super.messageCount,
  });

  factory HistoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data() ?? {};

    return HistoryModel(
      id: doc.id,
      title: json['title'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      type: json['type'] ?? 'Chat',

      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),

      messageCount: json['messageCount'] ?? 0,
    );
  }
}
