import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../firebase_options.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ??= FirebaseService._();

  FirebaseService._();

  late final FirebaseAuth auth;
  late final FirebaseFirestore firestore;
  late final FirebaseDatabase database;
  late final FirebaseStorage storage;

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    database = FirebaseDatabase.instance;
    storage = FirebaseStorage.instance;

    // Enable Firestore offline persistence
    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    _initialized = true;
  }

  // Current user helpers
  User? get currentUser => auth.currentUser;
  String? get currentUserId => currentUser?.uid;
  bool get isAuthenticated => currentUser != null;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => auth.authStateChanges();
}
