import 'package:material_ui/material_ui.dart';

import './routing/router.dart';
import './theme/theme.dart';

final class MarketAssistantApp extends StatelessWidget {
  const MarketAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Market Assistant',
      themeMode: ThemeMode.system,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      routerConfig: appRouter,
    );
  }
}
