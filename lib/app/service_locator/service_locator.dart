import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_streaming/core/network/api_service.dart';
import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/auth/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:music_streaming/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:music_streaming/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:music_streaming/features/auth/data/repository/remote_repository/user_remote_repository.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_view_model.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:music_streaming/features/song/data/data_source/local_data_source/song_local_data_source.dart';
import 'package:music_streaming/features/song/data/data_source/remote_data_source/song_remote_data_source.dart';
import 'package:music_streaming/features/song/data/repository/local_repository/song_local_repository.dart';
import 'package:music_streaming/features/song/data/repository/remote_repository/song_remote_repository.dart';
import 'package:music_streaming/features/song/domain/use_case/create_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/delete_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_all_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_featured_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_made_for_you_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_by_id_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_by_name_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_trending_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/update_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/upload_audio_file_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/upload_cover_image_usecase.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';
import 'package:music_streaming/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async{
  await _initHiveService();
  await _initApiService();
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

Future<void> _initApiService() async {
  serviceLocator.registerLazySingleton(() => ApiService(Dio()));
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

  serviceLocator.registerFactory(
    () => UserRemoteDataSource(apiService: serviceLocator<ApiService>())
  );

  // Repository
  serviceLocator.registerFactory(
    () => UserLocalRepository(userLocalDataSource: serviceLocator<UserLocalDataSource>())
  );
    
  serviceLocator.registerFactory(
    () => UserRemoteRepository(userRemoteDataSource: serviceLocator<UserRemoteDataSource>())
  );

  // UseCase
  // serviceLocator.registerFactory(
  //   () => UserRegisterUsecase(userRepository: serviceLocator<UserLocalRepository>())
  // );

  serviceLocator.registerFactory(
    () => UserRegisterUsecase(userRepository: serviceLocator<UserRemoteRepository>())
  );

  // serviceLocator.registerFactory(
  //   () => UserLoginUsecase(userRepository: serviceLocator<UserLocalRepository>())
  // );

  serviceLocator.registerFactory(
    () => UserLoginUsecase(userRepository: serviceLocator<UserRemoteRepository>())
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

  serviceLocator.registerFactory(() => 
    SongRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory(() => 
    SongLocalRepository(songLocalDataSource: serviceLocator<SongLocalDataSource>()),
  );

  serviceLocator.registerFactory(() => 
    SongRemoteRepository(songRemoteDataSource: serviceLocator<SongRemoteDataSource>()),
  );

  // Use Case
  serviceLocator.registerFactory(
    () => CreateSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => DeleteSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetAllSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetFeaturedSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetMadeForYouSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetSongByIdUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetSongByNameUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => GetTrendingSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => UpdateSongUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => UploadAudioFileUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  serviceLocator.registerFactory(
    () => UploadCoverImageUsecase(songRepository: serviceLocator<SongRemoteRepository>())
  );

  // View Model
  serviceLocator.registerLazySingleton(
    () => SongViewModel(
      createSongUsecase: serviceLocator<CreateSongUsecase>(),
      deleteSongUsecase: serviceLocator<DeleteSongUsecase>(),
      getAllSongUsecase: serviceLocator<GetAllSongUsecase>(),
      getFeaturedSongUsecase: serviceLocator<GetFeaturedSongUsecase>(),
      getMadeForYouSongUsecase: serviceLocator<GetMadeForYouSongUsecase>(),
      getSongByIdUsecase: serviceLocator<GetSongByIdUsecase>(),
      getSongByNameUsecase: serviceLocator<GetSongByNameUsecase>(),
      getTrendingSongUsecase: serviceLocator<GetTrendingSongUsecase>(),
      updateSongUsecase: serviceLocator<UpdateSongUsecase>(),
      uploadAudioFileUsecase: serviceLocator<UploadAudioFileUsecase>(),
      uploadCoverImageUsecase: serviceLocator<UploadCoverImageUsecase>(),
    ),
  );
}