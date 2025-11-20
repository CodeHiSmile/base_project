import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  updateApiRepository(context);
  updateDomainExport(context);
}

String toPascalCase(String input) {
  return input.split(RegExp(r'_| |\t|-')).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join();
}

String toSnakeCase(String input) {
  // Replace spaces, hyphens and uppercase transitions with underscores
  final regex = RegExp(r'(?<=[a-z0-9])(?=[A-Z])|[\s\-]+');
  return input.split(regex).map((word) => word.toLowerCase()).join('_');
}

String toCamelCase(String input) {
  final parts = input
      .split(RegExp(r'[\s_\-]+')) // split on spaces, underscores, hyphens
      .where((part) => part.isNotEmpty)
      .toList();

  if (parts.isEmpty) return '';

  // Lowercase the first word
  final firstWord = parts.first.toLowerCase();

  // Capitalize the rest
  final remaining = parts.skip(1).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join();

  return firstWord + remaining;
}

Future<void> updateApiRepository(HookContext context) async {
  final repoName = context.vars['feature_name'] as String?;
  final fileName = toSnakeCase((repoName ?? "") + '_repository');
  final filePath = 'lib/domain/repositories/${fileName}.dart';
  final repoFile = File(filePath);

  if (!repoFile.existsSync()) {
    context.logger.err('❌ $filePath not found.');
    return;
  }

  final content = repoFile.readAsStringSync();
  final className = toPascalCase((repoName ?? "") + " Repository");
  // Get the function name from Mason context
  final actionType = context.vars['action_type'] as String?;
  final entityName = context.vars['entity_name'] as String?;
  final functionActionType = (actionType ?? '').toLowerCase();
  final functionEntityName = (entityName ?? '');
  final functionName =
      toCamelCase(functionActionType + "_" + functionEntityName);
  if (functionName.isEmpty) {
    context.logger.err('❌ No function name provided in context.');
    return;
  }

  final regString = r'abstract class ' + className + r' \s*{([\s\S]*?)^}';
  // Match the abstract class Repository
  final classPattern = RegExp(regString, multiLine: true);
  final match = classPattern.firstMatch(content);

  if (match == null) {
    context.logger.err('❌ abstract class $className not found in $filePath.');
    return;
  }

  final newAbstractMethod = '''
  
  Future<void> $functionName();
''';

  // Inject the new method before the final closing brace
  final updatedContent = content.replaceFirstMapped(
    classPattern,
    (m) => 'abstract class $className {${m.group(1)}$newAbstractMethod\n}',
  );

  repoFile.writeAsStringSync(updatedContent);

  context.logger.info('✅ Added $functionName() to abstract class $className.');
}

Future<void> updateDomainExport(HookContext context) async {
  final featureName = context.vars['feature_name'] as String?;
  final actionType = context.vars['action_type'] as String?;
  final entityName = context.vars['entity_name'] as String?;
  final featureSnakeCase = toSnakeCase((featureName ?? ""));
  final fileEntity = toSnakeCase((entityName ?? "")) + '_entity';
  final fileUseCase = (actionType != null && actionType.isNotEmpty)
      ? '${toSnakeCase(actionType)}_${toSnakeCase(entityName ?? "")}_use_case'
      : '${toSnakeCase(entityName ?? "")}_use_case';

  final fileEntityPath = 'models/entity/${featureSnakeCase}/${fileEntity}.dart';
  final fileUseCasePath = 'usecases/${featureSnakeCase}/${fileUseCase}.dart';
  const fileDomainPath = 'lib/domain/domain.dart';
  final fileDomain = File(fileDomainPath);

  if (!fileDomain.existsSync()) {
    context.logger.err('❌ $fileDomainPath not found.');
    return;
  }

  // Read current content
  final lines = await fileDomain.readAsLines();
  final newExport = '''
export '$fileEntityPath';
export '$fileUseCasePath';
''';
  if (lines.isEmpty) {
    // If file is empty, just write new content
    await fileDomain.writeAsString(newExport);
  } else {
    await fileDomain.writeAsString('\n$newExport', mode: FileMode.append);
  }

  context.logger.info('✅ Added $fileEntity and $fileUseCase to $fileDomain.');
}
