import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/firebase_service.dart';

// Firebase Service provider
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService.instance;
});

// Individual Firebase service providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return ref.watch(firebaseServiceProvider).auth;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return ref.watch(firebaseServiceProvider).firestore;
});

final realtimeDatabaseProvider = Provider<FirebaseDatabase>((ref) {
  return ref.watch(firebaseServiceProvider).database;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return ref.watch(firebaseServiceProvider).storage;
});

// Auth state stream provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});

// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});
