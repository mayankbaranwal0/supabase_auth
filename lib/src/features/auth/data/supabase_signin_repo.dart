import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseSigninRepo {
  Future<void> signInWithEmailPassword(
      {required String email, required String password});
  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<User?> checkUserSession();
  Future<void> deleteUser();
  Future<void> googleSignIn();
}

final supabaseSigninRepoProvider = Provider<SupabaseSigninRepo>((ref) {
  return SupabaseSigninRepoImpl();
});

class SupabaseSigninRepoImpl implements SupabaseSigninRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<User?> checkUserSession() async {
    return _supabase.auth.currentUser;
  }

  @override
  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {}
  }

  @override
  Future<void> deleteUser() async {
    // await _supabase.auth.admin.deleteUser(_supabase.auth.currentUser!.id);
    await _supabase.functions.invoke('delete_user_account');

    // if (response.error != null) {
    //   throw Exception(response.error!.message);
    // }

    // Clear local auth state
    await _supabase.auth.signOut();
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> googleSignIn() async {
    /// Web Client ID that you registered with Google Cloud.
    final webClientId = dotenv.env['WEB_CLIENT_ID']!;

    /// iOS Client ID that you registered with Google Cloud.
    final iosClientId = dotenv.env['IOS_CLIENT_ID']!;
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
      scopes: ['email'],
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
