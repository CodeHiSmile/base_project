// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_project/app/app_bloc/app_bloc.dart' as _i528;
import 'package:base_project/data/api/client/auth_app_server_api_client.dart'
    as _i1051;
import 'package:base_project/data/api/client/none_auth_app_server_api_client.dart'
    as _i218;
import 'package:base_project/data/api/client/refresh_token_api_client.dart'
    as _i1018;
import 'package:base_project/data/api/interceptors/refresh_token_interceptor.dart'
    as _i483;
import 'package:base_project/data/api/service/app_api_service.dart' as _i877;
import 'package:base_project/data/api/service/refresh_token_api_service.dart'
    as _i510;
import 'package:base_project/data/mapper/auth/api_token_data_mapper.dart'
    as _i419;
import 'package:base_project/data/repository_impls/user_repository_impl.dart'
    as _i185;
import 'package:base_project/domain/repositories/user_repository.dart' as _i719;
import 'package:base_project/domain/usecases/user/get_user_use_case.dart'
    as _i679;
import 'package:base_project/domain/usecases/user/listen_user_profile_stream_use_case.dart'
    as _i153;
import 'package:base_project/navigation/bottom_sheet_impl.dart' as _i460;
import 'package:base_project/navigation/dialog_impl.dart' as _i656;
import 'package:base_project/presentation/features/create_order/bloc/create_order_bloc.dart'
    as _i258;
import 'package:base_project/presentation/features/home/bloc/home_bloc.dart'
    as _i357;
import 'package:base_project/presentation/features/login/bloc/login_bloc.dart'
    as _i1014;
import 'package:base_project/presentation/features/main/bloc/main_bloc.dart'
    as _i244;
import 'package:base_project/presentation/features/product/product_detail/bloc/product_detail_bloc.dart'
    as _i256;
import 'package:base_project/presentation/features/product/product_list/bloc/product_list_bloc.dart'
    as _i834;
import 'package:base_project/presentation/features/profile/bloc/profile_bloc.dart'
    as _i996;
import 'package:base_project/presentation/features/splash/bloc/splash_bloc.dart'
    as _i397;
import 'package:base_ui/base_ui.dart' as _i377;
import 'package:data/data.dart' as _i437;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/shared.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i419.ApiTokenDataMapper>(() => _i419.ApiTokenDataMapper());
    gh.factory<_i258.CreateOrderBloc>(() => _i258.CreateOrderBloc());
    gh.factory<_i357.HomeBloc>(() => _i357.HomeBloc());
    gh.factory<_i1014.LoginBloc>(() => _i1014.LoginBloc());
    gh.factory<_i244.MainBloc>(() => _i244.MainBloc());
    gh.factory<_i256.ProductDetailBloc>(() => _i256.ProductDetailBloc());
    gh.factory<_i834.ProductListBloc>(() => _i834.ProductListBloc());
    gh.factory<_i996.ProfileBloc>(() => _i996.ProfileBloc());
    gh.factory<_i397.SplashBloc>(() => _i397.SplashBloc());
    gh.lazySingleton<_i528.AppBloc>(
      () => _i528.AppBloc(gh<_i494.GetInitialAppDataUseCase>()),
    );
    gh.lazySingleton<_i377.BaseBottomSheet>(() => _i460.BottomSheetImpl());
    gh.lazySingleton<_i377.BaseDialog>(() => _i656.AppDialogImpl());
    gh.lazySingleton<_i1018.RefreshTokenApiClient>(
      () => _i1018.RefreshTokenApiClient(
        gh<_i437.HeaderInterceptor>(),
        gh<_i437.AccessTokenInterceptor>(),
      ),
    );
    gh.lazySingleton<_i218.NoneAuthAppServerApiClient>(
      () => _i218.NoneAuthAppServerApiClient(gh<_i437.HeaderInterceptor>()),
    );
    gh.lazySingleton<_i510.RefreshTokenApiService>(
      () => _i510.RefreshTokenApiService(
        gh<_i1018.RefreshTokenApiClient>(),
        gh<_i811.EnvironmentConfig>(),
      ),
    );
    gh.factory<_i483.RefreshTokenInterceptor>(
      () => _i483.RefreshTokenInterceptor(
        gh<_i437.AppPreferences>(),
        gh<_i510.RefreshTokenApiService>(),
        gh<_i218.NoneAuthAppServerApiClient>(),
      ),
    );
    gh.lazySingleton<_i1051.AuthAppServerApiClient>(
      () => _i1051.AuthAppServerApiClient(
        gh<_i437.HeaderInterceptor>(),
        gh<_i437.AccessTokenInterceptor>(),
        gh<_i483.RefreshTokenInterceptor>(),
      ),
    );
    gh.lazySingleton<_i877.AppApiService>(
      () => _i877.AppApiService(
        gh<_i218.NoneAuthAppServerApiClient>(),
        gh<_i1051.AuthAppServerApiClient>(),
      ),
    );
    gh.lazySingleton<_i719.UserRepository>(
      () => _i185.UserRepositoryImpl(gh<_i877.AppApiService>()),
    );
    gh.factory<_i679.GetUserUseCase>(
      () => _i679.GetUserUseCase(gh<_i719.UserRepository>()),
    );
    gh.factory<_i153.ListenUserProfileStreamUseCase>(
      () => _i153.ListenUserProfileStreamUseCase(gh<_i719.UserRepository>()),
    );
    return this;
  }
}
