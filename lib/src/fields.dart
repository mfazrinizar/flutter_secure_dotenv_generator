import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_secure_dotenv/flutter_secure_dotenv.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

final _fieldKeyChecker = const TypeChecker.fromRuntime(FieldKey);

/// Abstract class representing a field with its associated metadata.
abstract class Field<T> {
  /// Creates an instance of [Field].
  const Field(
    this._element,
    this.jsonKey,
    this.value,
  );

  /// Factory method to create a [Field] instance based on the type of the field.
  static Field<dynamic> of({
    required FieldElement element,
    required FieldRename rename,
    required String? nameOverride,
    DartObject? defaultValue,
    DotEnv? values,
  }) {
    assert(
      nameOverride == null || rename == FieldRename.none,
      'Cannot use both nameOverride and rename',
    );

    final type = element.type;
    final jsonKey = getElementJsonKey(element, rename, nameOverride);
    final value = values?[jsonKey] ?? defaultValue?.toStringValue();

    if (type.isDartCoreString) {
      return StringField(element, jsonKey, value);
    } else if (type.isDartCoreInt) {
      return IntField(element, jsonKey, value);
    } else if (type.isDartCoreDouble) {
      return DoubleField(element, jsonKey, value);
    } else if (type.isDartCoreBool) {
      return BoolField(element, jsonKey, value);
    } else if (type.isEnum) {
      final name = defaultValue?.getField('_name')?.toStringValue();
      return EnumField(element, jsonKey, value ?? name);
    }

    throw UnsupportedError(
        'Unsupported type for ${element.enclosingElement3.name}.$jsonKey: $type');
  }

  /// Returns the JSON key for the given [element] based on the [rename] strategy and [nameOverride].
  static String getElementJsonKey(
    FieldElement element,
    FieldRename rename,
    String? nameOverride,
  ) {
    final key = element.name;
    String jsonKey;

    switch (rename) {
      case FieldRename.none:
        jsonKey = key;
        break;
      case FieldRename.pascal:
        jsonKey = key.pascal;
        break;
      case FieldRename.snake:
        jsonKey = key.snake;
        break;
      case FieldRename.kebab:
        jsonKey = key.kebab;
        break;
      case FieldRename.screamingSnake:
        jsonKey = key.snake.toUpperCase();
        break;
    }

    return nameOverride ?? jsonKey;
  }

  final FieldElement _element;

  /// The JSON key associated with the field.
  final String jsonKey;

  /// The value associated with the field.
  final String? value;

  /// Returns the type of the field.
  DartType get type => _element.type;

  /// Returns the prefix for the type, if any.
  String? get typePrefix {
    final identifier = type.element?.library?.identifier;
    if (identifier == null) return null;

    for (final e in _element.library.importedLibraries) {
      if (e.library.identifier != identifier) continue;
      return e.name;
    }
    return null;
  }

  /// Returns the type with its prefix and nullability information.
  String typeWithPrefix({required bool withNullability}) {
    final typePrefix = this.typePrefix;
    final type = this.type.getDisplayString();
    if (typePrefix == 'dart.core') {
      return type;
    }
    return '${typePrefix?.isNotEmpty ?? false ? '$typePrefix.' : ''}$type';
  }

  /// Checks if the field is nullable.
  bool get isNullable => type.nullabilitySuffix != NullabilitySuffix.none;

  /// Parses the value of the field.
  T? parseValue();

  /// Returns the value of the field as a string.
  String? valueAsString() => parseValue()?.toString();

  /// Generates the code for the field.
  String generate() {
    final value = valueAsString();
    if (value == null && !isNullable) {
      throw Exception('No environment variable found for: $jsonKey');
    }

    return """
      @override
      ${typeWithPrefix(withNullability: true)} get ${_element.name} => _get('$jsonKey');
    """;
  }

  /// Generates a map entry for the field.
  MapEntry<String, String> generateMapEntry() {
    final value = valueAsString();
    if (value == null && !isNullable) {
      throw Exception('No environment variable found for: $jsonKey');
    }

    return MapEntry(jsonKey, value!);
  }
}

/// A class representing a string field.
class StringField extends Field<String> {
  /// Creates an instance of [StringField].
  const StringField(
    super.element,
    super.name,
    super.value,
  );

  @override
  String? parseValue() => value;

  @override
  String? valueAsString() {
    return parseValue();
  }
}

/// A class representing an integer field.
class IntField extends Field<int> {
  /// Creates an instance of [IntField].
  const IntField(
    super.element,
    super.name,
    super.value,
  );

  @override
  int? parseValue() {
    if (value == null) return null;
    return int.parse(value!);
  }
}

/// A class representing a double field.
class DoubleField extends Field<double> {
  /// Creates an instance of [DoubleField].
  const DoubleField(
    super.element,
    super.name,
    super.value,
  );

  @override
  double? parseValue() {
    if (value == null) return null;
    return double.parse(value!);
  }
}

/// A class representing a boolean field.
class BoolField extends Field<bool> {
  /// Creates an instance of [BoolField].
  const BoolField(
    super.element,
    super.name,
    super.value,
  );

  @override
  bool? parseValue() {
    switch (value?.toLowerCase()) {
      case null:
        return null;
      case 'true':
      case '1':
      case 'yes':
        return true;
      case 'false':
      case '0':
      case 'no':
      case '':
        return false;
      default:
        throw Exception('Invalid boolean value: $value');
    }
  }
}

/// A class representing an enum field.
class EnumField extends Field<String> {
  /// Creates an instance of [EnumField].
  const EnumField(
    super.element,
    super.name,
    super.value,
  );

  @override
  String? parseValue() {
    if (value == null) return null;

    final values = (type as InterfaceType)
        .accessors
        .where((e) => e.returnType.isAssignableTo(type))
        .map((e) => e.name);
    if (!values.contains(value)) {
      throw Exception('Invalid enum value for $type: $value');
    }

    return values.firstWhere((e) => e == value!.split('.').last);
  }

  @override
  String generate() {
    final value = parseValue();
    if (value == null && !isNullable) {
      throw Exception('No environment variable found for: $jsonKey');
    }

    return """
      @override
      ${typeWithPrefix(withNullability: true)} get ${_element.name} => _get(
        '$jsonKey',
        fromString: ${typeWithPrefix(withNullability: false)}.values.byName,
      );
    """;
  }

  @override
  String? valueAsString() {
    final value = parseValue();
    if (value == null) return null;
    return '${typeWithPrefix(withNullability: true)}.$value';
  }
}

/// A class representing field information.
class FieldInfo {
  /// Creates an instance of [FieldInfo].
  FieldInfo(
    this.name,
    this.defaultValue,
  );

  /// The name of the field.
  final String? name;

  /// The default value of the field.
  final DartObject? defaultValue;
}

/// Returns the field annotation for the given [element].
FieldInfo? getFieldAnnotation(Element element) {
  var obj = _fieldKeyChecker.firstAnnotationOfExact(element);
  if (obj == null) return null;

  return FieldInfo(
    obj.getField('name')?.toStringValue(),
    obj.getField('defaultValue'),
  );
}
