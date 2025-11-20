import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _createRepositoryImplFile(context);
}

String toSnakeCase(String input) {
  return input
      .replaceAllMapped(
          RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
      .replaceFirst('_', '');
}

String toPascalCase(String input) {
  return input
      .split(RegExp(r'[_\s]+'))
      .map((s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1))
      .join();
}

Future<void> _createRepositoryImplFile(HookContext context) async {
  final featureName = context.vars['feature_name'] as String?;
  final repoName = featureName?.trim() ?? "";

  final fileName = "${toSnakeCase(repoName)}_repository_impl";
  final interfaceName = "${toSnakeCase(repoName)}_repository";

  final filePath = "lib/data/repository_impls/$fileName.dart";
  final file = File(filePath);

  if (file.existsSync()) {
    context.logger.info("ℹ️ RepositoryImpl file already exists → $filePath");
    return;
  }

  // Ensure directory exists
  file.parent.createSync(recursive: true);

  final className = toPascalCase("${repoName}_repository").pascalCase;
  final classNameImpl = "${className}Impl";

  final content = '''
import 'package:base_project/data/api/service/app_api_service.dart';
import 'package:base_project/domain/repositories/$interfaceName.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: $className)
class $classNameImpl implements $className {
  final AppApiService _appApiService;

  $classNameImpl(this._appApiService);
}
''';

  file.writeAsStringSync(content);

  context.logger.success("✅ Created repository impl file → $filePath");
}
