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
    apiKey: 'AIzaSyCVOrm8kzuldObWOdeQWgUYeda9r07lQjY',
    appId: '1:191223311207:web:5d1d38ff5e260ed9001dc2',
    messagingSenderId: '191223311207',
    projectId: 'gridscout-52d9b',
    authDomain: 'gridscout-52d9b.firebaseapp.com',
    storageBucket: 'gridscout-52d9b.appspot.com',
    measurementId: 'G-RLG06W5J9J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyyAEEOMsUcvWwwui8AA5oBUH2ocxs-as',
    appId: '1:191223311207:android:c66a2bb2d18fecd5001dc2',
    messagingSenderId: '191223311207',
    projectId: 'gridscout-52d9b',
    storageBucket: 'gridscout-52d9b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAenT3xuEk4FTFal74V4TlS0p17Y0J3v5w',
    appId: '1:191223311207:ios:3be75d0250dc6fdc001dc2',
    messagingSenderId: '191223311207',
    projectId: 'gridscout-52d9b',
    storageBucket: 'gridscout-52d9b.appspot.com',
    iosClientId:
        '191223311207-bu5cauqabl4u6jgr2s7ud7gk95tdq769.apps.googleusercontent.com',
    iosBundleId: 'com.example.asugs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAenT3xuEk4FTFal74V4TlS0p17Y0J3v5w',
    appId: '1:191223311207:ios:3be75d0250dc6fdc001dc2',
    messagingSenderId: '191223311207',
    projectId: 'gridscout-52d9b',
    storageBucket: 'gridscout-52d9b.appspot.com',
    iosClientId:
        '191223311207-bu5cauqabl4u6jgr2s7ud7gk95tdq769.apps.googleusercontent.com',
    iosBundleId: 'com.example.asugs',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCVOrm8kzuldObWOdeQWgUYeda9r07lQjY',
    appId: '1:191223311207:web:46a2c7e1fdf00b43001dc2',
    messagingSenderId: '191223311207',
    projectId: 'gridscout-52d9b',
    authDomain: 'gridscout-52d9b.firebaseapp.com',
    storageBucket: 'gridscout-52d9b.appspot.com',
    measurementId: 'G-RF0BH5ZLLN',
  );
}