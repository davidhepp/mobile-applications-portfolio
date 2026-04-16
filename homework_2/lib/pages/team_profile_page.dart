import 'package:flutter/material.dart';

import '../data/team_members.dart';
import '../widgets/sidebar/language_tile.dart';
import '../widgets/sidebar/settings_tile.dart';
import '../widgets/team_member_carousel.dart';

class TeamProfilePage extends StatelessWidget {
  const TeamProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Group 3 Team Profile App',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        /*bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Welcome To The Team 3 Profile App',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),*/
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(
          255,
          247,
          241,
          255,
        ), // Very light purple
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
        ),
        width: 280,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 70, 28, 24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.deepPurple.shade300,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'SETTINGS',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Settings List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
                      child: Text(
                        'GENERAL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const LanguageTile(),
                    const SizedBox(height: 4),
                    SettingsTile(
                      title: 'Theme',
                      icon: Icons.palette_outlined,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.black12,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 16),

                    const Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        'ABOUT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SettingsTile(
                      title: 'About the Project',
                      icon: Icons.info_outline,
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              // Footer
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Team Profile App',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: TeamMemberCarousel(
          members: teamMembers,
          topSection: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(35, 16, 24, 0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to our Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E1E1E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We are Group 3, a team of students from THWS and TAMK working on this project together.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6B6B6B),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),

                    // subtle divider instead of just space
                    Divider(
                      thickness: 1,
                      color: Color(0xFFE5E5E5),
                      indent: 60,
                      endIndent: 60,
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Meet our Team:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
