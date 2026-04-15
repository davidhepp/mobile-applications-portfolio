import 'package:flutter/material.dart';

import 'pages/team_profile_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group 3 Team Profile App',
      home: TeamProfilePage(),
    );
  }
}
