// This placeholder exists so the app compiles before running `flutterfire configure`.
// After running the command below, this file will be overwritten with real values:
//   flutterfire configure --project=<your_project_id>

// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        authDomain: '',
        storageBucket: '',
        measurementId: '',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          storageBucket: '',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          iosBundleId: '',
          iosClientId: '',
          storageBucket: '',
        );
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          iosBundleId: '',
          iosClientId: '',
          storageBucket: '',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform. Run flutterfire configure.',
        );
    }
  }
}

