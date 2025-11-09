import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:flutter_secure_dotenv_generator/src/annotation_generator.dart';
import 'package:flutter_secure_dotenv_generator/src/environment_field.dart';
import 'package:flutter_secure_dotenv_generator/src/helpers.dart';
import 'package:pub_semver/src/version.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

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
      final element = TopLevelFunctionElementImpl('testFunction');
      final annotation = ConstantReader(null);
      final buildStep = BuildStepMock();

      expect(
        () => generator.generateForAnnotatedElement(
          element,
          annotation,
          buildStep,
        ),
        throwsException,
      );
    });
  });

  group('EnvironmentField', () {
    test('should create an instance of EnvironmentField', () {
      final field = EnvironmentField(
        'name',
        'nameOverride',
        DartTypeImpl('String'),
        DartObjectImpl('defaultValue'),
      );

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

class MetadataImpl implements Metadata {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TopLevelFunctionElementImpl implements TopLevelFunctionElement {
  @override
  final String name;

  TopLevelFunctionElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ClassElementImpl implements ClassElement {
  @override
  final String name;

  ClassElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

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
  Metadata get metadata => MetadataImpl();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class InterfaceElementImpl implements InterfaceElement {
  @override
  final String name;

  InterfaceElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

  @override
  List<InterfaceType> get allSupertypes => [];

  @override
  List<GetterElement> get getters => [
    GetterElementImpl('getter1'),
    GetterElementImpl('getter2'),
  ];

  @override
  List<SetterElement> get setters => [
    SetterElementImpl('setter1'),
    SetterElementImpl('setter2'),
  ];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class LibraryElementImpl implements LibraryElement {
  @override
  final String name;

  LibraryElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetterElementImpl implements GetterElement {
  @override
  final String name;

  GetterElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

  @override
  T? accept<T>(ElementVisitor2<T> visitor) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  T? accept2<T>(ElementVisitor2<T> visitor) {
    // TODO: implement accept2
    throw UnimplementedError();
  }

  @override
  // TODO: implement baseElement
  GetterElement get baseElement => throw UnimplementedError();

  @override
  // TODO: implement children
  List<Element> get children => throw UnimplementedError();

  @override
  // TODO: implement children2
  List<Element> get children2 => throw UnimplementedError();

  @override
  // TODO: implement correspondingSetter
  SetterElement? get correspondingSetter => throw UnimplementedError();

  @override
  // TODO: implement correspondingSetter2
  SetterElement? get correspondingSetter2 => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  String displayString({bool multiline = false, bool preferTypeAlias = false}) {
    // TODO: implement displayString
    throw UnimplementedError();
  }

  @override
  String displayString2({
    bool multiline = false,
    bool preferTypeAlias = false,
  }) {
    // TODO: implement displayString2
    throw UnimplementedError();
  }

  @override
  // TODO: implement documentationComment
  String? get documentationComment => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement
  Element get enclosingElement => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement2
  Element get enclosingElement2 => throw UnimplementedError();

  @override
  // TODO: implement firstFragment
  GetterFragment get firstFragment => throw UnimplementedError();

  @override
  // TODO: implement formalParameters
  List<FormalParameterElement> get formalParameters =>
      throw UnimplementedError();

  @override
  // TODO: implement fragments
  List<GetterFragment> get fragments => throw UnimplementedError();

  @override
  String getExtendedDisplayName({String? shortName}) {
    // TODO: implement getExtendedDisplayName
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName2({String? shortName}) {
    // TODO: implement getExtendedDisplayName2
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasImplicitReturnType
  bool get hasImplicitReturnType => throw UnimplementedError();

  @override
  // TODO: implement id
  int get id => throw UnimplementedError();

  @override
  // TODO: implement isAbstract
  bool get isAbstract => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement library) {
    // TODO: implement isAccessibleIn
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    // TODO: implement isAccessibleIn2
    throw UnimplementedError();
  }

  @override
  bool isDeprecatedWithKind(String kind) {
    // TODO: implement isDeprecatedWithKind
    throw UnimplementedError();
  }

  @override
  // TODO: implement isExtensionTypeMember
  bool get isExtensionTypeMember => throw UnimplementedError();

  @override
  // TODO: implement isExternal
  bool get isExternal => throw UnimplementedError();

  @override
  // TODO: implement isPrivate
  bool get isPrivate => throw UnimplementedError();

  @override
  // TODO: implement isPublic
  bool get isPublic => throw UnimplementedError();

  @override
  // TODO: implement isSimplyBounded
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  // TODO: implement isStatic
  bool get isStatic => throw UnimplementedError();

  @override
  // TODO: implement isSynthetic
  bool get isSynthetic => throw UnimplementedError();

  @override
  // TODO: implement kind
  ElementKind get kind => throw UnimplementedError();

  @override
  // TODO: implement library
  LibraryElement get library => throw UnimplementedError();

  @override
  // TODO: implement library2
  LibraryElement get library2 => throw UnimplementedError();

  @override
  // TODO: implement lookupName
  String? get lookupName => throw UnimplementedError();

  @override
  // TODO: implement metadata2
  Metadata get metadata2 => throw UnimplementedError();

  @override
  // TODO: implement name3
  String? get name3 => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic
  Element get nonSynthetic => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic2
  Element get nonSynthetic2 => throw UnimplementedError();

  @override
  // TODO: implement returnType
  DartType get returnType => throw UnimplementedError();

  @override
  // TODO: implement session
  AnalysisSession? get session => throw UnimplementedError();

  @override
  // TODO: implement sinceSdkVersion
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching
    throw UnimplementedError();
  }

  @override
  Element? thisOrAncestorMatching2(bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching2
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    // TODO: implement thisOrAncestorOfType
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType2<E extends Element>() {
    // TODO: implement thisOrAncestorOfType2
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  FunctionType get type => throw UnimplementedError();

  @override
  // TODO: implement typeParameters
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  // TODO: implement typeParameters2
  List<TypeParameterElement> get typeParameters2 => throw UnimplementedError();

  @override
  // TODO: implement variable
  PropertyInducingElement get variable => throw UnimplementedError();

  @override
  // TODO: implement variable3
  PropertyInducingElement? get variable3 => throw UnimplementedError();

  @override
  void visitChildren<T>(ElementVisitor2<T> visitor) {
    // TODO: implement visitChildren
  }

  @override
  void visitChildren2<T>(ElementVisitor2<T> visitor) {
    // TODO: implement visitChildren2
  }
}

class SetterElementImpl implements SetterElement {
  @override
  final String name;

  SetterElementImpl(this.name);

  @override
  Metadata get metadata => MetadataImpl();

  @override
  T? accept<T>(ElementVisitor2<T> visitor) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  T? accept2<T>(ElementVisitor2<T> visitor) {
    // TODO: implement accept2
    throw UnimplementedError();
  }

  @override
  // TODO: implement baseElement
  SetterElement get baseElement => throw UnimplementedError();

  @override
  // TODO: implement children
  List<Element> get children => throw UnimplementedError();

  @override
  // TODO: implement children2
  List<Element> get children2 => throw UnimplementedError();

  @override
  // TODO: implement correspondingGetter
  GetterElement? get correspondingGetter => throw UnimplementedError();

  @override
  // TODO: implement correspondingGetter2
  GetterElement? get correspondingGetter2 => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  String displayString({bool multiline = false, bool preferTypeAlias = false}) {
    // TODO: implement displayString
    throw UnimplementedError();
  }

  @override
  String displayString2({
    bool multiline = false,
    bool preferTypeAlias = false,
  }) {
    // TODO: implement displayString2
    throw UnimplementedError();
  }

  @override
  // TODO: implement documentationComment
  String? get documentationComment => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement
  Element get enclosingElement => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement2
  Element get enclosingElement2 => throw UnimplementedError();

  @override
  // TODO: implement firstFragment
  SetterFragment get firstFragment => throw UnimplementedError();

  @override
  // TODO: implement formalParameters
  List<FormalParameterElement> get formalParameters =>
      throw UnimplementedError();

  @override
  // TODO: implement fragments
  List<SetterFragment> get fragments => throw UnimplementedError();

  @override
  String getExtendedDisplayName({String? shortName}) {
    // TODO: implement getExtendedDisplayName
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName2({String? shortName}) {
    // TODO: implement getExtendedDisplayName2
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasImplicitReturnType
  bool get hasImplicitReturnType => throw UnimplementedError();

  @override
  // TODO: implement id
  int get id => throw UnimplementedError();

  @override
  // TODO: implement isAbstract
  bool get isAbstract => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement library) {
    // TODO: implement isAccessibleIn
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    // TODO: implement isAccessibleIn2
    throw UnimplementedError();
  }

  @override
  bool isDeprecatedWithKind(String kind) {
    // TODO: implement isDeprecatedWithKind
    throw UnimplementedError();
  }

  @override
  // TODO: implement isExtensionTypeMember
  bool get isExtensionTypeMember => throw UnimplementedError();

  @override
  // TODO: implement isExternal
  bool get isExternal => throw UnimplementedError();

  @override
  // TODO: implement isPrivate
  bool get isPrivate => throw UnimplementedError();

  @override
  // TODO: implement isPublic
  bool get isPublic => throw UnimplementedError();

  @override
  // TODO: implement isSimplyBounded
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  // TODO: implement isStatic
  bool get isStatic => throw UnimplementedError();

  @override
  // TODO: implement isSynthetic
  bool get isSynthetic => throw UnimplementedError();

  @override
  // TODO: implement kind
  ElementKind get kind => throw UnimplementedError();

  @override
  // TODO: implement library
  LibraryElement get library => throw UnimplementedError();

  @override
  // TODO: implement library2
  LibraryElement get library2 => throw UnimplementedError();

  @override
  // TODO: implement lookupName
  String? get lookupName => throw UnimplementedError();

  @override
  // TODO: implement metadata2
  Metadata get metadata2 => throw UnimplementedError();

  @override
  // TODO: implement name3
  String? get name3 => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic
  Element get nonSynthetic => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic2
  Element get nonSynthetic2 => throw UnimplementedError();

  @override
  // TODO: implement returnType
  DartType get returnType => throw UnimplementedError();

  @override
  // TODO: implement session
  AnalysisSession? get session => throw UnimplementedError();

  @override
  // TODO: implement sinceSdkVersion
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching
    throw UnimplementedError();
  }

  @override
  Element? thisOrAncestorMatching2(bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching2
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    // TODO: implement thisOrAncestorOfType
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType2<E extends Element>() {
    // TODO: implement thisOrAncestorOfType2
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  FunctionType get type => throw UnimplementedError();

  @override
  // TODO: implement typeParameters
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  // TODO: implement typeParameters2
  List<TypeParameterElement> get typeParameters2 => throw UnimplementedError();

  @override
  // TODO: implement variable
  PropertyInducingElement get variable => throw UnimplementedError();

  @override
  // TODO: implement variable3
  PropertyInducingElement? get variable3 => throw UnimplementedError();

  @override
  void visitChildren<T>(ElementVisitor2<T> visitor) {
    // TODO: implement visitChildren
  }

  @override
  void visitChildren2<T>(ElementVisitor2<T> visitor) {
    // TODO: implement visitChildren2
  }
}
