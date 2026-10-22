import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './routing/router.dart';
import './theme/theme.dart';

final class MarketAssistantApp extends StatefulWidget {
  const MarketAssistantApp({super.key});

  @override
  State<MarketAssistantApp> createState() => _MarketAssistantAppState();
}

final class _MarketAssistantAppState extends State<MarketAssistantApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Market Assistant',
      themeMode: ThemeMode.system,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      routerConfig: _router,
    );
  }
}
