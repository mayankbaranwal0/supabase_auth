import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth/src/app.dart';

Future<void> bootstrap() async {
  runApp(ProviderScope(child: const App()));
}