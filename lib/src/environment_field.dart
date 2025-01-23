import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

/// Represents a field in the environment with its associated metadata.
class EnvironmentField {
  /// The name of the field.
  final String name;

  /// The name override for the field, if any.
  final String? nameOverride;

  /// The type of the field.
  final DartType type;

  /// The default value for the field, if any.
  final DartObject? defaultValue;

  /// Creates an instance of [EnvironmentField].
  EnvironmentField(
    this.name,
    this.nameOverride,
    this.type,
    this.defaultValue,
  );
}
