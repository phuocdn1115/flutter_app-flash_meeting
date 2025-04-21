import 'package:firebase_core/firebase_core.dart';
import 'package:flash_meeting_app/core/router/app_router.dart';
import 'package:flash_meeting_app/core/theme/app_theme.dart';
import 'package:flash_meeting_app/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp.router(
    theme: AppTheme.getTheme(),
    routerConfig: AppRouter.router,
  ));
}
