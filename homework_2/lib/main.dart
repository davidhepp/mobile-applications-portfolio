import 'package:flutter/material.dart';

// Member data model class
class Member {
  final String name;
  final String role;
  final String intro;
  final String homeCountry;
  final String motto;
  final String imagePath;

  Member({
    required this.name,
    required this.role,
    required this.intro,
    required this.homeCountry,
    required this.motto,
    required this.imagePath,
  });
}

// Team data list
final List<Member> teamMembers = [
  Member(
    name: 'Member One',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member1.png',
  ),
  Member(
    name: 'Member Two',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member2.png',
  ),
  Member(
    name: 'Member Three',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member3.png',
  ),
  Member(
    name: 'Member Four',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member4.png',
  ),
  Member(
    name: 'Member Five',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member5.png',
  ),
  Member(
    name: 'Member Six',
    role: 'Team Role',
    intro: 'Short introduction here',
    homeCountry: 'Country Name',
    motto: 'Personal motto',
    imagePath: 'assets/images/member6.png',
  ),
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
