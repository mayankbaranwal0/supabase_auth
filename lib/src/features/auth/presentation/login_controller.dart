import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_signin_repo.dart';
import 'profile_controller.dart'; // Make sure this contains EmailAuthRepo and emailAuthRepoProvider

final loginController =
    StateNotifierProvider<LoginController, AsyncValue<void>>(
  (ref) => LoginController(ref),
);

class LoginController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  LoginController(this.ref) : super(const AsyncData(null));

  ProfileController get profile => ref.read(profileController.notifier);

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(supabaseSigninRepoProvider)
          .signInWithEmailPassword(email: email, password: password);
      await profile.init();
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      print('error ${e.message}');
      state = AsyncError(e.message, st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();
    try {
      await ref.read(supabaseSigninRepoProvider).signUpWithEmailPassword(
            email: email,
            password: password,
          );
      await profile.init();
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      state = AsyncError(e.message, st);
    }
  }
}
