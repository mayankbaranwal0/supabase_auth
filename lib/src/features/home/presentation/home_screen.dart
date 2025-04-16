import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../theme/app_fonts.dart';
import '../../auth/presentation/profile_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileController);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Spacer(),
            Text(
              user!.email!,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black.withOpacity(0.6),
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.radioCanadaBig,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            CustomButton.primary(
              onPressed: () => showDeleteAccountDialog(context, () async {
                await ref.read(profileController.notifier).deleteUser();
              }),
              child: Text(
                'Delete My Account',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.radioCanadaBig,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            gapH16,
            CustomButton.secondary(
              onPressed: () => ref.read(profileController.notifier).signOut(),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.radioCanadaBig,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDeleteAccountDialog(
    BuildContext context, VoidCallback onConfirm) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(); // close the dialog
              onConfirm(); // execute your delete function
            },
          ),
        ],
      );
    },
  );
}
