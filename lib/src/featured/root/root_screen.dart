import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth/src/featured/onboarding/onboarding_screen.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScreen();
  }
}
