import 'package:batch_34a/app/shared_pref/token_shared_pref.dart';
import 'package:batch_34a/core/network/hive_service.dart';
import 'package:batch_34a/features/auth/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:batch_34a/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_image_upload_usecase.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:batch_34a/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch_34a/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:batch_34a/features/dashboard/presentation/view_model/dashboard_screen_view_model.dart';
import 'package:batch_34a/features/splash/presentation/view_model/spashscreen_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();

  await _initSharedPrefs();

  await _initAuthModule();
  await _initDashboardModule();
  await _initSplashModule();
}


Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> _initSharedPrefs() async {

  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);
  serviceLocator.registerLazySingleton(
    () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}


Future<void> _initAuthModule() async {

  serviceLocator.registerFactory(
    () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );


  serviceLocator.registerFactory(
    () => UserLocalRepository(
      userLocalDatasource: serviceLocator<UserLocalDatasource>(),
    ),
  );



  serviceLocator.registerFactory(
    () => RegisterViewModel(
      serviceLocator<UserRegisterUsecase>(),
      serviceLocator<UserImageUploadUsecase>(),
    ),
  );


  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

Future<void> _initDashboardModule() async {
  serviceLocator.registerFactory(
    () => DashboardScreenViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
  );
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}
