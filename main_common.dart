import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/artists/artists_screen.dart';
import 'ui/screens/library/library_screen.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/states/settings_state.dart';
import 'ui/theme/theme.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LibraryScreen(),
    ArtistsScreen(),   // W9-02
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final AppSettingsState settingsState = context.watch<AppSettingsState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        backgroundColor: settingsState.theme.backgroundColor,
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: settingsState.theme.color,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),   // W9-02
              label: 'Artists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}