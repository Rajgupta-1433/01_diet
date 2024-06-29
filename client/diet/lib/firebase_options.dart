// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD1FyCNLV9UnfbbdW4mPbLY1SY6IxsXb68',
    appId: '1:20961837598:web:be14326210c04cc4f7e40f',
    messagingSenderId: '20961837598',
    projectId: 'diet-01-32967',
    authDomain: 'diet-01-32967.firebaseapp.com',
    storageBucket: 'diet-01-32967.appspot.com',
    measurementId: 'G-C1JJDY9JF8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFILI52mduqEw1gJAuuBT-BU2CVijNNe8',
    appId: '1:20961837598:android:8ff84ad0c1365281f7e40f',
    messagingSenderId: '20961837598',
    projectId: 'diet-01-32967',
    storageBucket: 'diet-01-32967.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDaMrC7-OC75XgX_u5jC6zKiN7VluroXY',
    appId: '1:20961837598:ios:7072e6bba9944caef7e40f',
    messagingSenderId: '20961837598',
    projectId: 'diet-01-32967',
    storageBucket: 'diet-01-32967.appspot.com',
    iosBundleId: 'com.example.diet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDaMrC7-OC75XgX_u5jC6zKiN7VluroXY',
    appId: '1:20961837598:ios:7072e6bba9944caef7e40f',
    messagingSenderId: '20961837598',
    projectId: 'diet-01-32967',
    storageBucket: 'diet-01-32967.appspot.com',
    iosBundleId: 'com.example.diet',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1FyCNLV9UnfbbdW4mPbLY1SY6IxsXb68',
    appId: '1:20961837598:web:96033a8fa34ee888f7e40f',
    messagingSenderId: '20961837598',
    projectId: 'diet-01-32967',
    authDomain: 'diet-01-32967.firebaseapp.com',
    storageBucket: 'diet-01-32967.appspot.com',
    measurementId: 'G-X5R18W3FXT',
  );
}