import 'package:get_it/get_it.dart';
import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/auth/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:music_streaming/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_view_model.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:music_streaming/features/song/data/data_source/local_data_source/song_local_data_source.dart';
import 'package:music_streaming/features/song/data/repository/local_repository/song_local_repository.dart';
import 'package:music_streaming/features/song/domain/use_case/add_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/delete_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_usecase.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';
import 'package:music_streaming/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async{
  await _initHiveService();

  await _initSplashModule();
  await _initDashboardModule();
  await _initAuthModule();
  // await _initHomeModule();
  await _initSongModule();
  // await _initPlaylistsModule();
  // await _initAlbumModule();

  // await _initHomeModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future _initDashboardModule() async{
  serviceLocator.registerLazySingleton(() => DashboardViewModel());
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}

Future _initAuthModule() async {

  // Data Source 
  serviceLocator.registerFactory(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>())
  );

  // Repository
  serviceLocator.registerFactory(
    () => UserLocalRepository(userLocalDataSource: serviceLocator<UserLocalDataSource>())
  );

  // UseCase
  serviceLocator.registerFactory(
    () => UserRegisterUsecase(userRepository: serviceLocator<UserLocalRepository>())
  );

  serviceLocator.registerFactory(
    () => UserLoginUsecase(userRepository: serviceLocator<UserLocalRepository>())
  );


  // View Models
  serviceLocator.registerFactory(
    () => RegisterViewModel(
      serviceLocator<UserRegisterUsecase>(),
    ),
  );

  // user login service locator view model
  serviceLocator.registerFactory(
    () => LoginViewModel(
      serviceLocator<UserLoginUsecase>()
    ),
  );
}

Future _initSongModule() async {
  
  // Data Source
  serviceLocator.registerFactory(() => 
    SongLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // Repository
  serviceLocator.registerFactory(() => 
    SongLocalRepository(songLocalDataSource: serviceLocator<SongLocalDataSource>()),
  );

  // Use Case
  serviceLocator.registerFactory(() =>
    AddSongUsecase(iSongRepository: serviceLocator<SongLocalRepository>()),
  );

  serviceLocator.registerFactory(() =>
    DeleteSongUsecase(iSongRepository: serviceLocator<SongLocalRepository>()),
  );

  serviceLocator.registerFactory(() =>
    GetSongUsecase(iSongRepository: serviceLocator<SongLocalRepository>()),
  );

  // View Model
  serviceLocator.registerLazySingleton(() => SongViewModel(
    addSongUsecase: serviceLocator<AddSongUsecase>(),
    deleteSongUsecase: serviceLocator<DeleteSongUsecase>(),
    getSongUsecase: serviceLocator<GetSongUsecase>(),
  ));
}