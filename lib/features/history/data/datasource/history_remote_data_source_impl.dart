import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/history_model.dart';
import 'history_remote_data_source.dart';

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  HistoryRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<List<HistoryModel>> getHistory() async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final snapshot = await firestore
        .collection('user')
        .doc(user.uid)
        .collection('conversations')
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs.map((e) => HistoryModel.fromFirestore(e)).toList();
  }
}
