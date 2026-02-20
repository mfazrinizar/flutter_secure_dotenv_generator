import 'dart:convert';

import 'package:flutter_secure_dotenv/flutter_secure_dotenv.dart';
import 'package:flutter_secure_dotenv_generator/src/helpers.dart';
import 'package:test/test.dart';

void main() {
  group('Helpers - escapeDartString', () {
    test('should escape simple string', () {
      final result = escapeDartString('hello');
      expect(result, "'hello'");
    });

    test('should handle string with single quotes', () {
      final result = escapeDartString("it's");
      expect(result, '"it\'s"');
    });

    test('should handle string with double quotes', () {
      final result = escapeDartString('say "hello"');
      expect(result, "'say \"hello\"'");
    });

    test('should handle string with dollar sign', () {
      final result = escapeDartString(r'cost $5');
      expect(result, contains(r'$'));
    });

    test('should handle string with newline', () {
      final result = escapeDartString('line1\nline2');
      expect(result, contains(r'\n'));
    });

    test('should handle string with tab', () {
      final result = escapeDartString('col1\tcol2');
      expect(result, contains(r'\t'));
    });

    test('should handle string with carriage return', () {
      final result = escapeDartString('line1\rline2');
      expect(result, contains(r'\r'));
    });

    test('should handle empty string', () {
      final result = escapeDartString('');
      expect(result, "''");
    });

    test('should handle backslash', () {
      final result = escapeDartString(r'path\to\file');
      expect(result, contains(r'\\'));
    });
  });

  group('AES encryption integration (used by generator)', () {
    test('encrypt and decrypt JSON map (simulates generator workflow)', () {
      final key = AESCBCEncrypter.generateRandomBytes(32);
      final iv = AESCBCEncrypter.generateRandomBytes(16);

      final envMap = {
        'API_KEY': 'sk-1234567890abcdef',
        'DATABASE_URL': 'postgres://user:pass@localhost:5432/db',
        'DEBUG': 'true',
        'PORT': '3000',
      };

      // Encrypt individual values (as the generator does)
      final encryptedEntries = <String, String>{};
      for (final entry in envMap.entries) {
        final encrypted = base64.encode(
          AESCBCEncrypter.aesCbcEncrypt(key, iv, entry.value),
        );
        encryptedEntries[entry.key] = encrypted;
      }

      // Encrypt the whole JSON map (as the generator does)
      final jsonEncoded = jsonEncode(encryptedEntries);
      final encryptedJson = AESCBCEncrypter.aesCbcEncrypt(key, iv, jsonEncoded);

      // Decrypt the whole JSON map (as the runtime does)
      final decryptedJson = AESCBCEncrypter.aesCbcDecrypt(
        key,
        iv,
        encryptedJson,
      );
      final jsonMap = jsonDecode(decryptedJson) as Map<String, dynamic>;

      // Decrypt individual values
      for (final entry in envMap.entries) {
        final encryptedValue = jsonMap[entry.key] as String;
        final decryptedValue = AESCBCEncrypter.aesCbcDecrypt(
          key,
          iv,
          base64.decode(encryptedValue),
        );
        expect(decryptedValue, entry.value);
      }
    });

    test('base64 key/IV round-trip (simulates key file workflow)', () {
      final key = AESCBCEncrypter.generateRandomBytes(32);
      final iv = AESCBCEncrypter.generateRandomBytes(16);

      // Serialize to JSON file format
      final secretsMap = {
        'ENCRYPTION_KEY': base64.encode(key),
        'IV': base64.encode(iv),
      };
      final jsonStr = jsonEncode(secretsMap);

      // Deserialize
      final loaded = jsonDecode(jsonStr) as Map<String, dynamic>;
      final loadedKey = base64.decode(loaded['ENCRYPTION_KEY']! as String);
      final loadedIv = base64.decode(loaded['IV']! as String);

      expect(Uint8List.fromList(loadedKey), equals(key));
      expect(Uint8List.fromList(loadedIv), equals(iv));

      // Verify encryption still works with deserialized keys
      const text = 'secret value';
      final encrypted = AESCBCEncrypter.aesCbcEncrypt(
        Uint8List.fromList(loadedKey),
        Uint8List.fromList(loadedIv),
        text,
      );
      final decrypted = AESCBCEncrypter.aesCbcDecrypt(
        Uint8List.fromList(loadedKey),
        Uint8List.fromList(loadedIv),
        encrypted,
      );
      expect(decrypted, text);
    });

    test('unencrypted base64 workflow (no encryption keys)', () {
      final envMap = {'API_KEY': 'my-api-key', 'SECRET': 'my-secret'};

      // Simulate unencrypted path: base64-encode values
      final encodedEntries = <String, String>{};
      for (final entry in envMap.entries) {
        encodedEntries[entry.key] = base64.encode(entry.value.codeUnits);
      }

      final jsonEncoded = jsonEncode(encodedEntries);
      final encryptedJson = base64.encode(jsonEncoded.codeUnits);

      // Decode
      final bytes = base64.decode(encryptedJson);
      final stringDecoded = String.fromCharCodes(bytes);
      final jsonMap = jsonDecode(stringDecoded) as Map<String, dynamic>;

      for (final entry in envMap.entries) {
        final encryptedValue = jsonMap[entry.key] as String;
        final decryptedValue = String.fromCharCodes(
          base64.decode(encryptedValue),
        );
        expect(decryptedValue, entry.value);
      }
    });
  });

  group('FieldRename integration', () {
    test('all FieldRename values accessible', () {
      expect(FieldRename.values, hasLength(5));
    });

    test('DotEnvGen accepts all FieldRename values', () {
      for (final rename in FieldRename.values) {
        final gen = DotEnvGen(fieldRename: rename);
        expect(gen.fieldRename, rename);
      }
    });
  });
}
