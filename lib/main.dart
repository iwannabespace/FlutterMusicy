import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musicy/features/music/domain/entities/music.dart';

import 'di/injection_container.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await Hive.initFlutter();
  await setup();
  await dotenv.load(fileName: ".env");

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(getIt<MusicAdapter>());
  }

  runApp(const MusicyApp());
}
