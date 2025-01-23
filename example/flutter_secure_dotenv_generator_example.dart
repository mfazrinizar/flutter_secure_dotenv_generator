// Below is an example of how to use the secure dotenv generator in your project.
// Please see flutter_secure_dotenv package readme for more information.
// Have a .env file with the following content:

import 'package:flutter_secure_dotenv/flutter_secure_dotenv.dart';

part 'env.g.dart';

@DotEnvGen(
  filename: '.env',
  fieldRename: FieldRename.screamingSnake,
)
abstract class Env {
  static Env create() {
    String encryptionKey = const String.fromEnvironment(
        "APP_ENCRYPTION_KEY"); // On build, change with your generated encryption key (use dart-define for String.fromEnvironment)
    String iv = const String.fromEnvironment(
        "APP_IV_KEY"); // On build, change with your generated iv (use dart-define for String.fromEnvironment)
    return Env(encryptionKey, iv);
  }

  const factory Env(String encryptionKey, String iv) =
      _$Env; // You can call const config = Env('encryption-key', 'iv') from another Dart file using this

  // The unused_element warning will be removed after env.g.dart is generated
  // ignore: unused_element
  const Env._();

  // Declare your environment variables as abstract getters
  @FieldKey(defaultValue: "")
  String get apiBaseUrl;

  @FieldKey(defaultValue: "")
  String get apiWebSocketUrl;

  @FieldKey(defaultValue: "")
  String get apiPredictionEndpoint;

  // Android

  @FieldKey(defaultValue: "")
  String get androidApiKey;

  @FieldKey(defaultValue: "")
  String get androidAppId;

  @FieldKey(defaultValue: "")
  String get androidMessagingSenderId;

  @FieldKey(defaultValue: "")
  String get androidProjectId;

  @FieldKey(defaultValue: "")
  String get androidStorageBucket;

  // iOS

  @FieldKey(defaultValue: "")
  String get iosApiKey;

  @FieldKey(defaultValue: "")
  String get iosAppId;

  @FieldKey(defaultValue: "")
  String get iosMessagingSenderId;

  @FieldKey(defaultValue: "")
  String get iosProjectId;

  @FieldKey(defaultValue: "")
  String get iosStorageBucket;

  @FieldKey(defaultValue: "")
  String get iosBundleId;
}
