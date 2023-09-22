import 'package:get_it/get_it.dart';
import 'package:upload_file_practicle/src/uploadform/data/datasources/hive/upload_from_local_data_source_hive.dart';
import 'package:upload_file_practicle/src/uploadform/data/datasources/upload_form_local_data_source.dart';
import 'package:upload_file_practicle/src/uploadform/data/repository/upload_repository_impl.dart';
import 'package:upload_file_practicle/src/uploadform/domain/repositories/upload_repository.dart';
import 'package:upload_file_practicle/src/uploadform/domain/usecases/get_file_form.dart';
import 'package:upload_file_practicle/src/uploadform/domain/usecases/upload_form.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/bloc/upload_form_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => UploadFormBloc(
          getFormFile: sl(),
          uploadForm: sl(),
        ))

    // use cases
    ..registerLazySingleton(() => UploadForm(sl()))
    ..registerLazySingleton(() => GetFormFile())

    // repository
    ..registerLazySingleton<UploadRepository>(
        () => UploadRepositoryImpl(uploadFormLocalDataSource: sl()))

    // Data Sources
    ..registerLazySingleton<UploadFormLocalDataSource>(
        () => UploadFormLocalDataSourceHive());

  await sl<UploadFormLocalDataSource>().initDb();
}
