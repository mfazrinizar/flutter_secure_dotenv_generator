import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_secure_dotenv_generator/src/annotation_generator.dart';
import 'package:flutter_secure_dotenv_generator/src/environment_field.dart';
import 'package:flutter_secure_dotenv_generator/src/helpers.dart';
import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

void main() {
  group('FlutterSecureDotEnvAnnotationGenerator', () {
    late FlutterSecureDotEnvAnnotationGenerator generator;
    late BuilderOptions options;

    setUp(() {
      options = BuilderOptions({
        'ENCRYPTION_KEY': 'test_encryption_key',
        'IV': 'test_initialization_vector',
        'OUTPUT_FILE': 'test_output_file',
      });
      generator = FlutterSecureDotEnvAnnotationGenerator(options);
    });

    test('should throw exception if element is not a class', () async {
      final element = FunctionElementImpl('testFunction');
      final annotation = ConstantReader(null);
      final buildStep = BuildStepMock();

      expect(
        () => generator.generateForAnnotatedElement(
            element, annotation, buildStep),
        throwsException,
      );
    });
  });

  group('EnvironmentField', () {
    test('should create an instance of EnvironmentField', () {
      final field = EnvironmentField('name', 'nameOverride',
          DartTypeImpl('String'), DartObjectImpl('defaultValue'));

      expect(field.name, 'name');
      expect(field.nameOverride, 'nameOverride');
      expect(field.type, isA<DartType>());
      expect(field.defaultValue, isA<DartObject>());
    });
  });

  group('Helpers', () {
    test('should get all accessor names', () {
      final interface = InterfaceElementImpl('TestInterface');
      final accessorNames = getAllAccessorNames(interface);

      expect(accessorNames, isNotEmpty);
    });
  });
}

// ignore: subtype_of_sealed_class
class BuildStepMock implements BuildStep {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FunctionElementImpl implements FunctionElement {
  @override
  final String name;

  FunctionElementImpl(this.name);

  @override
  List<ElementAnnotation> get metadata => [];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ClassElementImpl implements ClassElement {
  @override
  final String name;

  ClassElementImpl(this.name);

  @override
  List<ElementAnnotation> get metadata => [];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DartTypeImpl implements DartType {
  @override
  final String name;

  DartTypeImpl(this.name);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DartObjectImpl implements DartObject {
  final dynamic value;

  DartObjectImpl(this.value);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FieldElementImpl implements FieldElement {
  @override
  final String name;
  @override
  final DartType type;

  FieldElementImpl(this.name, this.type);

  @override
  List<ElementAnnotation> get metadata => [];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class InterfaceElementImpl implements InterfaceElement {
  @override
  final String name;

  InterfaceElementImpl(this.name);

  @override
  List<ElementAnnotation> get metadata => [];

  @override
  List<InterfaceType> get allSupertypes => [];

  @override
  List<PropertyAccessorElement> get accessors => [
        PropertyAccessorElementImpl('accessor1', false),
        PropertyAccessorElementImpl('accessor2', false),
      ];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class LibraryElementImpl implements LibraryElement {
  @override
  final String name;

  LibraryElementImpl(this.name);

  @override
  List<ElementAnnotation> get metadata => [];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class PropertyAccessorElementImpl implements PropertyAccessorElement {
  @override
  final String name;
  @override
  final bool isSetter;

  PropertyAccessorElementImpl(this.name, this.isSetter);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
