import 'dart:async';

import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:base_project/app/my_app.dart';
import 'package:base_project/config/app_config.dart';
import 'package:base_ui/base_ui.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide RouterConfig;
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:router/router.dart';
import 'package:shared/shared.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void mainApp(EnvironmentConfig config) {
  GetIt.instance.registerLazySingleton<EnvironmentConfig>(() => config);
  setUrlStrategy(PathUrlStrategy());
  runZonedGuarded(_runMyApp, _reportError);
}

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  if (GetIt.instance.get<EnvironmentConfig>().getEnvironment() != Environment.production) {
    GetIt.instance.get<EnvironmentConfig>().setAlice(
      Alice(configuration: AliceConfiguration(showNotification: false)),
    );
  }

  EnvConstants.init();
  await SharedConfig.getInstance().init();
  await DataConfig.getInstance().init();
  await DomainConfig.getInstance().init();
  await BaseUiConfig.getInstance().init();
  await RouterConfig.getInstance().init();
  await AppConfig.getInstance().init();
  await Future.delayed(Duration(milliseconds: 200));

  runApp(const MyApp());
}

void _reportError(Object error, StackTrace stackTrace) {
  LogUtils.e(error, stackTrace: stackTrace, tag: 'Uncaught exception');
}
