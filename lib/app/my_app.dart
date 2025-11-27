import 'package:base_project/app/app_bloc/app_state.dart';
import 'package:base_project/di/di.dart';
import 'package:base_project/generated/l10n.dart';
import 'package:base_project/navigation/routers/app_router.dart';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:router/router.dart';
import 'package:shared/shared.dart';

import 'app_bloc/app_bloc.dart';
import 'app_bloc/app_event.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, AppBloc> {
  final _alice = GetIt.instance.get<EnvironmentConfig>().getAlice();
  final routerService = GetIt.instance.get<RouterService>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    routerService.registerRoutes(AppRouter.routerConfiguration());
    bloc.add(const AppInitiated());

    if (_alice != null) {
      _alice.setNavigatorKey(getIt<BaseNavigator>().navigatorKey);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initConfig();
    });
  }

  void _initConfig() async {
    final permission = await Geolocator.requestPermission();
    LogUtils.d("Permission: $permission");
    await configFcm();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          previous.isDarkTheme != current.isDarkTheme ||
          previous.languageCode != current.languageCode ||
          previous.debugOverlayButton != current.debugOverlayButton,
      builder: (context, state) {
        return MaterialApp.router(
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            final bottomPadding = data.padding.bottom;

            Offset position = Offset(
              data.size.width - 74,
              data.size.height - 130 - bottomPadding - 40,
            );

            return MediaQuery(
              data: data.copyWith(textScaler: const TextScaler.linear(1)),
              child: Stack(
                children: [
                  child ?? const SizedBox.shrink(),
                  if (_alice != null && state.debugOverlayButton)
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Positioned(
                          left: position.dx,
                          top: position.dy,
                          child: FloatingActionButton(
                            onPressed: () {
                              _alice.showInspector();
                            },
                            child: const Text('API'),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
          routerConfig: routerService.router,
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme.copyWith(
            extensions: [AppColorScheme.core(), AppTextStyles.core()],
            appBarTheme: AppBarTheme(
              backgroundColor: CoreColors.white,
              scrolledUnderElevation: 0.0,
            ),
          ),
          darkTheme: darkTheme.copyWith(
            extensions: [AppColorScheme.core(), AppTextStyles.core()],
          ),
          debugShowCheckedModeBanner: false,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) =>
                  supportedLocales.contains(locale)
                  ? locale
                  : const Locale(LocaleConstants.defaultLocale),
          locale: Locale(state.languageCode.localeCode),
          supportedLocales: AppStrings.delegate.supportedLocales,
          localizationsDelegates: const [
            AppStrings.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }

  Future configFcm() async {
    final env = GetIt.instance.get<EnvironmentConfig>().getEnvironment();

    bool isProduct = env == Environment.production;
    bool isStaging = env == Environment.staging;

    // if (isProduct) {
    //   await Firebase.initializeApp(
    //     options: prod.DefaultFirebaseOptions.currentPlatform,
    //   );
    // } else if (isStaging) {
    //   await Firebase.initializeApp(
    //     options: stg.DefaultFirebaseOptions.currentPlatform,
    //   );
    // } else {
    //   await Firebase.initializeApp(
    //     options: dev.DefaultFirebaseOptions.currentPlatform,
    //   );
    // }

    // await FcmConfig.init();

    // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };
  }
}
