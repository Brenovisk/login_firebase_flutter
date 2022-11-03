import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:login_firebase_flutter_test/src/services/auth_service.dart';
import './src/data/firebase_options.dart';
import 'package:provider/provider.dart';
import 'src/screens/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: MyApp(),
  ));
}
