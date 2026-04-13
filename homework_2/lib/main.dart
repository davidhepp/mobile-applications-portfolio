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
    name: 'David',
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(child: TeamMemberCarousel(members: teamMembers)),
        ),
      ),
    );
  }
}

class TeamMemberCarousel extends StatefulWidget {
  final List<Member> members;

  const TeamMemberCarousel({super.key, required this.members});

  @override
  State<TeamMemberCarousel> createState() => _TeamMemberCarouselState();
}

class _TeamMemberCarouselState extends State<TeamMemberCarousel> {
  late PageController _pageController;
  late int _initialPage;
  int _currentPage =
      0; // Represents the index of the currently highlighted member (0 to length-1)

  @override
  void initState() {
    super.initState();
    // Start at a large multiple of members.length to allow swiping left indefinitely
    _initialPage = widget.members.isNotEmpty ? widget.members.length * 1000 : 0;
    _pageController = PageController(
      viewportFraction: 0.5,
      initialPage: _initialPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.members.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page % widget.members.length;
              });
            },
            // Omitting itemCount creates an infinite List/PageView
            itemBuilder: (context, index) {
              final int realIndex = index % widget.members.length;

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                  } else {
                    value = index == _initialPage ? 1.0 : 0.0;
                  }

                  // 1.0 -> full opacity / scale = 1.0
                  // 0.0 -> lowest opacity / scale = 0.6
                  double opacity = 0.5 + (0.5 * value);
                  double scale = 0.6 + (0.4 * value);

                  return Center(
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.scale(scale: scale, child: child),
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    final int targetPage =
                        _pageController.page?.round() ?? _initialPage;
                    if (index != targetPage) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                      image: DecorationImage(
                        image: AssetImage(widget.members[realIndex].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            widget.members[_currentPage].name.toUpperCase(),
            key: ValueKey<String>(widget.members[_currentPage].name),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
