/// Code generator for [flutter_secure_dotenv](https://pub.dev/packages/flutter_secure_dotenv).
///
/// Reads `.env` files at build time, encrypts the values with AES-CBC, and
/// emits a `part` file containing the encrypted data.
library;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/annotation_generator.dart';

/// Creates a [SharedPartBuilder] for generating secure dotenv annotations.
///
/// Takes [options] as a parameter to configure the builder.
Builder flutterSecureDotEnvAnnotation(BuilderOptions options) =>
    SharedPartBuilder([
      FlutterSecureDotEnvAnnotationGenerator(options),
    ], 'flutter_secure_dot_env_annotation');
