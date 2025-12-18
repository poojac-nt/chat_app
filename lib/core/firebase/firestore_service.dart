import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._internal();

  static final FirestoreService _instance = FirestoreService._internal();

  static FirestoreService get instance => _instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}
