import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  validateRepository(context);
  updateDomainExportRepository(context);
  createUseCase(context);
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

Future<void> validateRepository(HookContext context) async {
  final logger = context.logger;

  final featureName = context.vars['feature_name'] as String?;
  if (featureName == null || featureName.trim().isEmpty) {
    logger.err('❌ feature_name is missing!');
    return;
  }

  final repoFileName = '${toSnakeCase(featureName)}_repository';
  final filePath = 'lib/domain/repositories/$repoFileName.dart';
  final file = File(filePath);

  // Nếu file chưa tồn tại thì tạo mới
  if (!file.existsSync()) {
    logger.warn('⚠️ $filePath not found. Creating file...');

    final className = toPascalCase('${featureName}_repository');

    final fileContent = '''
  abstract class $className {
    
  }
''';

    // Tạo thư mục trước khi tạo file
    file.createSync(recursive: true);
    file.writeAsStringSync(fileContent);

    logger.success('✨ Created $filePath');
  } else {
    logger.info('✔ $filePath already exists.');
  }
}

Future<void> updateDomainExportRepository(HookContext context) async {
  final featureName = context.vars['feature_name'] as String?;
  // 🔥 Repository file
  final repoFileName = '${toSnakeCase((featureName ?? ""))}_repository';
  final repoFilePath = 'repositories/$repoFileName.dart';

  // domain.dart location
  const fileDomainPath = 'lib/domain/domain.dart';
  final fileDomain = File(fileDomainPath);

  if (!fileDomain.existsSync()) {
    context.logger.err('❌ $fileDomainPath not found.');
    return;
  }

  // Read current content
  final lines = await fileDomain.readAsLines();

  // 🔥 Thêm cả export cho Entity + UseCase + Repository
  final newExport = '''
export '$repoFilePath';
''';

  if (lines.isEmpty) {
    await fileDomain.writeAsString(newExport);
  } else {
    await fileDomain.writeAsString('\n$newExport', mode: FileMode.append);
  }

  context.logger.info('✅ Added $repoFileName to $fileDomain.');
}

/*Future<void> createUseCase(HookContext context) async {
  final featureName = context.vars['feature_name'] as String?;
  final entityName = context.vars['entity_name'] as String?;
  final actionType = context.vars['action_type'] as String?;

  if (featureName == null || entityName == null) {
    context.logger.err('❌ feature_name or entity_name is missing!');
    return;
  }

  // 1️⃣ Tạo folder nếu chưa có
  final folderPath = 'domain/usecases/${toSnakeCase(featureName).snakeCase}';
  Directory(folderPath).createSync(recursive: true);

  // 2️⃣ Tính tên file
  final fileName = (actionType != null && actionType.isNotEmpty)
      ? '${toSnakeCase(actionType).snakeCase}_${toSnakeCase(entityName).snakeCase}_use_case.dart'
      : '${toSnakeCase(entityName).snakeCase}_use_case.dart';

  final oldPath = '$folderPath/_use_case.dart';
  final newPath = '$folderPath/$fileName';

  // 3️⃣ Rename file placeholder
  final file = File(oldPath);
  if (file.existsSync()) {
    file.renameSync(newPath);
    context.logger.info('✅ Created use case file: $fileName');
  } else {
    context.logger.err('❌ Placeholder _use_case.dart not found at $oldPath');
  }

  // 4️⃣ Tính className để dùng trong template
  final className = (actionType != null && actionType.isNotEmpty)
      ? '${toPascalCase(actionType).pascalCase}${toPascalCase(entityName).pascalCase}UseCase'
      : '${toPascalCase(entityName).pascalCase}UseCase';

  // 5️⃣ Gán biến className vào Mason context
  context.vars = {
    ...context.vars,
    'className': className,
  };
}*/

Future<void> createUseCase(HookContext context) async {
  final featureName = context.vars['feature_name'] as String?;
  final entityName = context.vars['entity_name'] as String?;
  final actionType = context.vars['action_type'] as String?;

  if (featureName == null || entityName == null) {
    context.logger.err('❌ feature_name or entity_name is missing!');
    return;
  }

  // 1️⃣ Tạo folder nếu chưa tồn tại
  final folderPath = 'lib/domain/usecases/${toSnakeCase(featureName)}';
  final folder = Directory(folderPath);

  if (!folder.existsSync()) {
    folder.createSync(recursive: true);
    context.logger.info('✅ Created folder: $folderPath');
  }

  // 2️⃣ Tính tên file
  final fileName = (actionType != null && actionType.isNotEmpty)
      ? '${toSnakeCase(actionType)}_${toSnakeCase(entityName)}_use_case.dart'
      : '${toSnakeCase(entityName)}_use_case.dart';

  final filePath = '$folderPath/$fileName';
  final file = File(filePath);

  // 3️⃣ Tạo file mới nếu chưa tồn tại
  if (!file.existsSync()) {
    final className = (actionType != null && actionType.isNotEmpty)
        ? '${toPascalCase(actionType)}${toPascalCase(entityName)}UseCase'
        : '${toPascalCase(entityName)}UseCase';

    final inputClass = '${className}Input';
    final outputClass = '${className}Output';
    final repositoryClass = '${toPascalCase(featureName)}Repository';
    final repositoryFileName = '${toSnakeCase(featureName)}_repository';

    file.writeAsStringSync('''
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../repositories/$repositoryFileName.dart';

@Injectable()
class $className extends BaseFutureUseCase<$inputClass, $outputClass> {
  const $className(this._repository);

  final $repositoryClass _repository;

  @override
  Future<$outputClass> buildUseCase($inputClass input) async {
    return $outputClass();
  }
}

class $inputClass extends BaseInput {
  const $inputClass();
}

class $outputClass extends BaseOutput {}
''');

    context.logger.success('✅ Created use case file: $filePath');
  } else {
    context.logger.info('ℹ️ File already exists: $filePath');
  }
}
