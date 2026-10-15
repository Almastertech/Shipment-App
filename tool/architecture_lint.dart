import 'dart:io';

void main() {
  final violations = <String>[];

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('lib/ directory not found.');
    exitCode = 1;
    return;
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));

  final importRegex = RegExp(
    r'''^import\s+["']([^"']+)["'];''',
    multiLine: true,
  );
  final dataSourceDeclarationRegex = RegExp(
    r'''(?:abstract\s+)?class\s+\w*DataSource\b''',
  );

  for (final file in dartFiles) {
    final path = file.path.replaceAll('\\', '/');
    final content = file.readAsStringSync();
    final imports = importRegex
        .allMatches(content)
        .map((m) => m.group(1) ?? '')
        .toList(growable: false);

    if (path.startsWith('lib/screens/')) {
      for (final import in imports) {
        if (import == 'package:dio/dio.dart' ||
            import.contains('/data/datasource/remote/dio/')) {
          violations.add(
            '$path -> presentation layer must not import Dio/network datasource directly: $import',
          );
        }
      }
    }

    if (path.startsWith('lib/data/repository/')) {
      for (final import in imports) {
        if (import.contains('/screens/') ||
            import.contains('package:flutter/material.dart') ||
            import.contains('package:flutter/widgets.dart')) {
          violations.add(
            '$path -> repository layer must not import UI/presentation: $import',
          );
        }
        if (import.contains('/datasource/remote/dio/') ||
            import.contains('/app_urls/')) {
          violations.add(
            '$path -> repository layer must not import transport details directly: $import',
          );
        }
      }

      if (dataSourceDeclarationRegex.hasMatch(content)) {
        violations.add(
          '$path -> repository layer must not declare DataSource types/implementations.',
        );
      }
    }

    if (path.startsWith('lib/data/datasource/')) {
      for (final import in imports) {
        if (import.contains('/screens/') ||
            import.contains('package:flutter/material.dart') ||
            import.contains('package:flutter/widgets.dart')) {
          violations.add(
            '$path -> datasource layer must not import UI/presentation: $import',
          );
        }
      }
    }

    if (path.startsWith('lib/features/')) {
      for (final import in imports) {
        if (import.endsWith('/injection.dart') ||
            import == '../injection.dart') {
          violations.add(
            '$path -> feature modules should avoid direct GetIt composition root imports: $import',
          );
        }
      }
    }
  }

  if (violations.isEmpty) {
    stdout.writeln('architecture_lint: no violations found.');
    return;
  }

  stderr.writeln('architecture_lint: ${violations.length} violation(s) found:');
  for (final violation in violations) {
    stderr.writeln('- $violation');
  }
  exitCode = 1;
}
