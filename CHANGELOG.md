## 2.0.0

- **BREAKING**: Updated `source_gen` from `^2.0.0` to `^4.2.0` (addresses [#3](https://github.com/mfazrinizar/flutter_secure_dotenv_generator/issues/3)).
  - Migrated from `TypeChecker.fromRuntime` to `TypeChecker.fromUrl` (source_gen 4.x breaking change).
  - Added `inPackage` to `GeneratorForAnnotation` for precise annotation matching.
- **BREAKING**: Updated `build` from `^2.4.2` to `>=3.0.0 <5.0.0`.
- **BREAKING**: Updated `analyzer` from `^7.2.0` to `>=8.0.0 <11.0.0`.
  - Migrated from `element.enclosingElement3` to `element.enclosingElement`.
  - Migrated from `interface.augmented.lookUpGetter/lookUpSetter` to `interface.lookUpGetter/lookUpSetter`.
  - Migrated from `accessor.variable2` to `accessor.variable`.
  - Migrated from `interface.accessors` to `interface.getters`/`interface.setters`.
  - Migrated from `library.importedLibraries` to `library.firstFragment.libraryImports`.
- **BREAKING**: Updated `pointycastle` from `^3.9.1` to `^4.0.0`.
- **BREAKING**: Minimum Dart SDK bumped from `^3.6.0` to `^3.8.0`.
- **Fix**: Generator no longer processes static/private fields (e.g. `_encryptionKey`, `_iv`) as environment variables.
- Updated `flutter_secure_dotenv` dependency to `^2.0.0`.
- Updated `source_helper` to `^1.3.10`, `lints` to `^6.1.0`, `test` to `^1.29.0`, `build_runner` to `^2.11.1`.
- Updated example to use secure key loading (removed `String.fromEnvironment` pattern).
- Added 100% `public_member_api_docs` coverage with library-level dartdoc.
- Enhanced test coverage from 3 to 14 tests.
- Added GitHub Actions CI workflow with dual-checkout and auto-generated `pubspec_overrides.yaml`.
- Added `CONTRIBUTING.md`.

## 1.0.5

- Fix enum typePrefix empty building issue

## 1.0.4

- Fix building without encryption

## 1.0.3

- Fix FormatterException caused by dart.core type prefix

## 1.0.2

- Fix building issue

## 1.0.1

- Minor typo fixes

## 1.0.0

- Initial version.
- Update dependencies, refactor codes and continue the discontinued secure_dotenv_generator
