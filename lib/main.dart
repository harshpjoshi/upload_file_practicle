import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_file_practicle/core/services/injection_container.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/bloc/upload_form_bloc.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/views/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadFormBloc>(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
