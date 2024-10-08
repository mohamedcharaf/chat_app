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
    apiKey: 'AIzaSyDEo9do9KgJ6qKEi0XLJa2F2TXSljRG6Ls',
    appId: '1:809086139215:web:a976259e01d18d5a19a33a',
    messagingSenderId: '809086139215',
    projectId: 'chat-app5-3e315',
    authDomain: 'chat-app5-3e315.firebaseapp.com',
    storageBucket: 'chat-app5-3e315.appspot.com',
    measurementId: 'G-EYEGMWXQ4B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAB6g_OpQtJtjGPZ52J7TvPKzu7e19_PU',
    appId: '1:809086139215:android:14f2bb579fdbbecd19a33a',
    messagingSenderId: '809086139215',
    projectId: 'chat-app5-3e315',
    storageBucket: 'chat-app5-3e315.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8gbmsXf2_1o4jY7x7HVzVMmxHPzEhnck',
    appId: '1:809086139215:ios:0852a9088d19818c19a33a',
    messagingSenderId: '809086139215',
    projectId: 'chat-app5-3e315',
    storageBucket: 'chat-app5-3e315.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8gbmsXf2_1o4jY7x7HVzVMmxHPzEhnck',
    appId: '1:809086139215:ios:0852a9088d19818c19a33a',
    messagingSenderId: '809086139215',
    projectId: 'chat-app5-3e315',
    storageBucket: 'chat-app5-3e315.appspot.com',
    iosBundleId: 'com.example.chat',
  );
}
