import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import './app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MarketAssistantApp());
}
