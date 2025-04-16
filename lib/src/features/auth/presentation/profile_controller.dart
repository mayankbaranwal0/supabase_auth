import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_signin_repo.dart';

class ProfileController extends StateNotifier<User?> {
  final Ref ref;
  ProfileController(this.ref) : super(null);

  bool get isLoggedIn => state != null;

  /// Check if a user is already signed in
  Future<void> init() async {
    state = await ref.read(supabaseSigninRepoProvider).checkUserSession();
  }

  /// Sign out
  Future<void> signOut() async {
    ref.read(supabaseSigninRepoProvider).signOut();
    state = null;
  }

  /// Delete User
  Future<void> deleteUser() async {
    ref.read(supabaseSigninRepoProvider).deleteUser();
    state = null;
  }
}

/// Riverpod Provider for ProfileController
final profileController = StateNotifierProvider<ProfileController, User?>(
  (ref) => ProfileController(ref),
);
