import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  updateApiFile(context);
  updateApiRepositoryImplFile(context);
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

Future<void> updateApiFile(HookContext context) async {
  const apiFilePath = 'lib/data/api/service/app_api_service.dart';
  final repoFile = File(apiFilePath);

  if (!repoFile.existsSync()) {
    context.logger.err('❌ $apiFilePath not found.');
    return;
  }

  final content = repoFile.readAsStringSync();

  // Get the function name from Mason context
  final entityName = context.vars['entity_name'] as String?;
  final methodName = context.vars['method'] as String?;
  final path = context.vars['path'] as String?;
  final functionActionType = (methodName ?? '').toLowerCase();
  final functionEntityName = (entityName ?? '');
  final modelName = toPascalCase(functionEntityName)+'Response';
  final functionName =
      toCamelCase(functionActionType + "_" + functionEntityName);
  if (functionName.isEmpty) {
    context.logger.err('❌ No function name provided in context.');
    return;
  }
  // Match the  class AppApiService
  final classPattern =
      RegExp(r'class AppApiService\s*{([\s\S]*?)^}', multiLine: true);
  final match = classPattern.firstMatch(content);

  if (match == null) {
    context.logger.err('❌ class AppApiService not found in $apiFilePath.');
    return;
  }

  final newAbstractMethod = ''' 
  
  Future<DataResponse<$modelName>?> $functionName() async {
    return _authAppServerApiClient.request(
      method: RestMethod.$methodName,
      path: '$path',
      decoder: (json){
        return $modelName.fromJson(json as Map<String, dynamic>);
      },
     );
  }
''';

  // Inject the new method before the final closing brace
  final updatedContent = content.replaceFirstMapped(
    classPattern,
    (m) => 'class AppApiService {${m.group(1)}$newAbstractMethod\n}',
  );

  repoFile.writeAsStringSync(updatedContent);

  context.logger.info('✅ Added $functionName() to class AppApiService.');
}

Future<void> updateApiRepositoryImplFile(HookContext context) async {
  final repoName = context.vars['feature_name'] as String?;
  final fileName = toSnakeCase((repoName ?? "") + '_repository_impl');

  final repositoryFilePath = 'lib/data/repository_impls/${fileName}.dart';

  final repoFile = File(repositoryFilePath);

  if (!repoFile.existsSync()) {
    context.logger.err('❌ $repositoryFilePath not found.');
    return;
  }

  final content = repoFile.readAsStringSync();
  final className = toPascalCase((repoName ?? "") + " Repository");
  final classNameImpl = className + "Impl";

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
  final regString = r'class ' +
      classNameImpl +
      r' implements ' +
      className +
      r' \s*{([\s\S]*?)^}';

  // Match the class RepositoryImpl
  final classPattern = RegExp(regString, multiLine: true);
  final match = classPattern.firstMatch(content);

  if (match == null) {
    context.logger.err('❌ class $classNameImpl not found in '
        '$repositoryFilePath.');
    return;
  }

  final newAbstractMethod = '''
  
  @override
  Future<void> $functionName() async {}
''';

  // Inject the new method before the final closing brace
  final updatedContent = content.replaceFirstMapped(
    classPattern,
    (m) =>
        'class $classNameImpl implements $className {${m.group(1)}$newAbstractMethod\n}',
  );

  repoFile.writeAsStringSync(updatedContent);

  context.logger.info('✅ Added $functionName() to class $classNameImpl.');
}
