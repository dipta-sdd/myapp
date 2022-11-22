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
    apiKey: 'AIzaSyAGj5QrwS6aCC3TkUX8oXTERFBdANp9_6M',
    appId: '1:963449971896:web:be91d24c58c55f547c804d',
    messagingSenderId: '963449971896',
    projectId: 'my-app-sdd',
    authDomain: 'my-app-sdd.firebaseapp.com',
    storageBucket: 'my-app-sdd.appspot.com',
    measurementId: 'G-CK3Y6DE4HK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBU9E20gNg9E3_eC2qgTp60CaUB-XiAuT0',
    appId: '1:963449971896:android:fc2100645960cad17c804d',
    messagingSenderId: '963449971896',
    projectId: 'my-app-sdd',
    storageBucket: 'my-app-sdd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChZkhwz-v_oRZ6QtCbOtWQzm-h_KakOyA',
    appId: '1:963449971896:ios:b36cc3b4a820ea497c804d',
    messagingSenderId: '963449971896',
    projectId: 'my-app-sdd',
    storageBucket: 'my-app-sdd.appspot.com',
    iosClientId: '963449971896-qkjrfln5rnp7l5sc9u1i422nj3uogbmk.apps.googleusercontent.com',
    iosBundleId: 'com.sdd.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChZkhwz-v_oRZ6QtCbOtWQzm-h_KakOyA',
    appId: '1:963449971896:ios:b36cc3b4a820ea497c804d',
    messagingSenderId: '963449971896',
    projectId: 'my-app-sdd',
    storageBucket: 'my-app-sdd.appspot.com',
    iosClientId: '963449971896-qkjrfln5rnp7l5sc9u1i422nj3uogbmk.apps.googleusercontent.com',
    iosBundleId: 'com.sdd.myapp',
  );
}