// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhb_M_Z_WnreMxZYL83Gw9MCk2p2kmZQk',
    appId: '1:1056629644293:web:109f3d8f4fc12b7ce5d06c',
    messagingSenderId: '1056629644293',
    projectId: 'loginfirebasefluttertest',
    authDomain: 'loginfirebasefluttertest.firebaseapp.com',
    storageBucket: 'loginfirebasefluttertest.appspot.com',
    measurementId: 'G-33PXY75BSK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUh0yiY48vjjZjwRjOnC-5Lb5TzjO5eC0',
    appId: '1:1056629644293:android:6c03aa69f4976e50e5d06c',
    messagingSenderId: '1056629644293',
    projectId: 'loginfirebasefluttertest',
    storageBucket: 'loginfirebasefluttertest.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDc4DovE5Pzn9m-GCgHfzVSL97PM1P7zEg',
    appId: '1:1056629644293:ios:63007b36fd66e999e5d06c',
    messagingSenderId: '1056629644293',
    projectId: 'loginfirebasefluttertest',
    storageBucket: 'loginfirebasefluttertest.appspot.com',
    iosClientId: '1056629644293-ftqb73se8vmv7s7ta2v64cu1s4rceirb.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginFirebaseFlutterTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDc4DovE5Pzn9m-GCgHfzVSL97PM1P7zEg',
    appId: '1:1056629644293:ios:63007b36fd66e999e5d06c',
    messagingSenderId: '1056629644293',
    projectId: 'loginfirebasefluttertest',
    storageBucket: 'loginfirebasefluttertest.appspot.com',
    iosClientId: '1056629644293-ftqb73se8vmv7s7ta2v64cu1s4rceirb.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginFirebaseFlutterTest',
  );
}
