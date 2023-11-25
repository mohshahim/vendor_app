import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
// final googleSignInProvider = Provider((ref) => GoogleSignIn());
final firebaseProvider = Provider((ref) => FirebaseFirestore.instance);
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) =>throw UnimplementedError());
final firebaseStorageProvider = Provider((ref) => FirebaseStorage.instance);