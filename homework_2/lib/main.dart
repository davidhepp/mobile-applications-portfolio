import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    name: 'Shayan Khurram',
    role: 'Team Role',
    intro: 'Software Engineering student at Tampere University of Applied Sciences.',
    homeCountry: 'Pakistan',
    motto: 'Aut viam inveniam aut faciam',
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
    name: 'Ayesha Siddiqua',
    role: 'Team Role',
    intro:
        'Software Engineering student at Tampere University of Applied Sciences.',
    homeCountry: 'Bangladesh',
    motto: 'Keep learning, never give up',
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
      title: 'Group 3 Team Profile App',
      home: Scaffold(
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
          bottom: const PreferredSize(
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
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 232, 208, 245),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                children: [
                  ListTile(
                    title: const Text('English'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Finnish'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('German'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TeamMemberCarousel(members: teamMembers),
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

class _TeamMemberCarouselState extends State<TeamMemberCarousel>
    with TickerProviderStateMixin {
  // Team note: Keep `homeCountry` updated with a real country name (or
  // a 2-letter ISO code like FI). The flag in the details panel updates
  // automatically from that value.
  static const Map<String, String> _countryNameToIso = {
    'bangladesh': 'BD',
    'germany': 'DE',
    'pakistan': 'PK',
    'finland': 'FI',
    'estonia': 'EE',
    'united arab emirates': 'AE',
    'uae': 'AE',
    'sweden': 'SE',
    'norway': 'NO',
    'denmark': 'DK',
    'netherlands': 'NL',
    'france': 'FR',
    'italy': 'IT',
    'spain': 'ES',
    'united kingdom': 'GB',
    'uk': 'GB',
    'ireland': 'IE',
    'india': 'IN',
    'china': 'CN',
    'japan': 'JP',
    'south korea': 'KR',
    'canada': 'CA',
    'united states': 'US',
    'usa': 'US',
    'australia': 'AU',
    'new zealand': 'NZ',
  };

  // Requested member defaults. If others update `homeCountry`, their flags
  // will come from that field automatically.
  static const Map<String, String> _memberCountryOverrides = {
    'David': 'Germany',
    'Shayan Khurram': 'Pakistan',
    'Ayesha Siddiqua': 'Bangladesh',
  };

  late PageController _pageController;
  late int _initialPage;
  late AnimationController _expandController;
  late AnimationController _hintController;
  late Animation<double> _hintOffset;

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

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _hintController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _hintOffset = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(
      CurvedAnimation(parent: _hintController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    _hintController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double _lerp(double from, double to, double t) {
    return from + (to - from) * t;
  }

  void _expandDetails() {
    if (_expandController.value > 0.98) return;
    HapticFeedback.lightImpact();

    _expandController.animateTo(
      1,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 450),
    );
  }

  void _collapseDetails() {
    if (_expandController.value < 0.02) return;
    HapticFeedback.lightImpact();

    _expandController.animateTo(
      0,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details, double maxDragDistance) {
    final double? delta = details.primaryDelta;
    if (delta == null || maxDragDistance <= 0) return;

    final double next = _expandController.value - (delta / maxDragDistance);
    _expandController.value = next.clamp(0.0, 1.0);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity ?? 0;

    if (velocity < -350) {
      _expandDetails();
      return;
    }

    if (velocity > 350) {
      _collapseDetails();
      return;
    }

    if (_expandController.value > 0.45) {
      _expandDetails();
    } else {
      _collapseDetails();
    }
  }

  String _buildInitials(String name) {
    final List<String> parts = name
        .split(' ')
        .where((String part) => part.trim().isNotEmpty)
        .toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  String _countryForMember(Member member) {
    final String country = _memberCountryOverrides[member.name] ?? member.homeCountry;
    return country.trim();
  }

  String _countryToFlagEmoji(String countryOrIso) {
    if (countryOrIso.trim().isEmpty) return '🌍';

    String isoCode = '';
    final String raw = countryOrIso.trim();
    final String normalized = raw.toLowerCase();
    final String upper = raw.toUpperCase();

    if (RegExp(r'^[A-Z]{2}$').hasMatch(upper)) {
      isoCode = upper;
    } else {
      isoCode = _countryNameToIso[normalized] ?? '';
    }

    if (isoCode.length != 2) return '🌍';

    final int first = isoCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int second = isoCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCodes([first, second]);
  }

  bool _isDavid(Member member) {
    return member.name.trim().toLowerCase() == 'david';
  }

  List<Color> _memberCardGradient(Member member) {
    if (_isDavid(member)) {
      // THWS-inspired orange palette.
      return const [Color(0xFFFFF2E4), Color(0xFFFFD9B0)];
    }

    // TAMK-inspired purple palette for all other members.
    return const [Color(0xFFF6F0FF), Color(0xFFE8D9FF)];
  }

  Color _memberAccent(Member member) {
    if (_isDavid(member)) {
      return const Color(0xFFEF7A24);
    }
    return const Color(0xFF6F38D6);
  }

  List<Color> _memberBackdrop(Member member) {
    if (_isDavid(member)) {
      return const [Color(0xFFFFFBF6), Color(0xFFFFF0DE)];
    }
    return const [Color(0xFFFDFBFF), Color(0xFFF2EAFF)];
  }

  String _memberUniversityLabel(Member member) {
    if (_isDavid(member)) {
      return 'THWS Germany';
    }
    return 'TAMK Finland';
  }

  Widget _buildMemberCarousel(double expansion, bool lockSwipe) {
    final double avatarSize = _lerp(200, 152, expansion);

    return PageView.builder(
      controller: _pageController,
      physics: lockSwipe
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      onPageChanged: (int page) {
        HapticFeedback.selectionClick();
        setState(() {
          _currentPage = page % widget.members.length;
        });
      },
      // Omitting itemCount creates an infinite List/PageView
      itemBuilder: (context, index) {
        final int realIndex = index % widget.members.length;
        final Member member = widget.members[realIndex];
        final Color accent = _memberAccent(member);

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;

            if (_pageController.hasClients &&
                _pageController.position.haveDimensions &&
                _pageController.page != null) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            } else {
              value = index == _initialPage ? 1.0 : 0.0;
            }

            // 1.0 -> full opacity / scale = 1.0
            // 0.0 -> lowest opacity / scale = 0.6
            final double opacity = 0.5 + (0.5 * value);
            final double scale = 0.6 + (0.4 * value);

            return Center(
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              final int targetPage = _pageController.page?.round() ?? _initialPage;
              if (index != targetPage) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
              width: avatarSize,
              height: avatarSize,
              padding: const EdgeInsets.all(2.4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: accent.withValues(alpha: 0.76),
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.34),
                    blurRadius: 15,
                    spreadRadius: 1.2,
                  ),
                  BoxShadow(
                    color: accent.withValues(alpha: 0.16),
                    blurRadius: 28,
                    spreadRadius: 2.5,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  member.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFEDE6F8),
                      alignment: Alignment.center,
                      child: Text(
                        _buildInitials(member.name),
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildName(Member member) {
    return AnimatedSwitcher(
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
        member.name.toUpperCase(),
        key: ValueKey<String>(member.name),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required Widget leading,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24, child: Center(child: leading)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(Member member) {
    final String country = _countryForMember(member);
    final String countryFlag = _countryToFlagEmoji(country);
    final Color accent = _memberAccent(member);
    final List<Color> cardGradient = _memberCardGradient(member);
    final String universityLabel = _memberUniversityLabel(member);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      child: Container(
        key: ValueKey<String>('details-${member.name}'),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardGradient,
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.1),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _collapseDetails,
                  child: Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                member.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                member.role,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.42),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: accent.withValues(alpha: 0.45)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.school, size: 15, color: accent),
                    const SizedBox(width: 6),
                    Text(
                      universityLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: accent,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _buildInfoRow(
                leading: const Icon(Icons.person_outline, size: 20, color: Colors.black54),
                label: 'INTRO',
                value: member.intro,
              ),
              _buildInfoRow(
                leading: Text(
                  countryFlag,
                  style: const TextStyle(fontSize: 20, height: 1.0),
                ),
                label: 'HOME COUNTRY',
                value: country,
              ),
              _buildInfoRow(
                leading: const Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: Colors.black54,
                ),
                label: 'MOTTO',
                value: member.motto,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.members.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenHeight = constraints.maxHeight;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            _onVerticalDragUpdate(details, screenHeight * 0.36);
          },
          onVerticalDragEnd: _onVerticalDragEnd,
          child: AnimatedBuilder(
            animation: Listenable.merge([_expandController, _hintController]),
            builder: (context, child) {
              final double rawExpansion = _expandController.value;
              final double expansion = Curves.easeOutCubic.transform(rawExpansion);
              final double profileMotion = Curves.easeOutQuart.transform(
                rawExpansion,
              );
              final double panelMotion = Curves.easeOutExpo.transform(
                rawExpansion,
              );

              final Member currentMember = widget.members[_currentPage];
              final List<Color> backdropColors = _memberBackdrop(currentMember);

              final double carouselHeight = _lerp(250, 210, profileMotion);
              final double carouselTop = _lerp(
                screenHeight * 0.20,
                16,
                profileMotion,
              );
              final double nameTop =
                  carouselTop + carouselHeight + _lerp(34, 18, profileMotion);

              final double basePanelTop = _lerp(
                screenHeight + 32,
                screenHeight * 0.34,
                panelMotion,
              );
              final double panelTop = basePanelTop < (nameTop + 52)
                  ? (nameTop + 52)
                  : basePanelTop;

              final double hintOpacity = (1 - (expansion * 1.8)).clamp(0.0, 1.0);
              final double closeOpacity = (expansion * 1.7).clamp(0.0, 1.0);
              final double scrimOpacity = (rawExpansion * 0.16).clamp(0.0, 0.16);
              final Color topBg = Color.lerp(
                Colors.white,
                backdropColors[0],
                expansion,
              )!;
              final Color bottomBg = Color.lerp(
                const Color(0xFFF6F6F8),
                backdropColors[1],
                expansion,
              )!;

              return Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [topBg, bottomBg],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: carouselTop,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: carouselHeight,
                      child: _buildMemberCarousel(expansion, rawExpansion > 0.78),
                    ),
                  ),
                  Positioned(
                    top: nameTop,
                    left: 16,
                    right: 16,
                    child: Center(
                      child: _buildName(currentMember),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: rawExpansion < 0.05,
                      child: GestureDetector(
                        onTap: _collapseDetails,
                        child: Container(
                          color: Colors.black.withValues(alpha: scrimOpacity),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: panelTop,
                    left: 16,
                    right: 16,
                    bottom: 12,
                    child: IgnorePointer(
                      ignoring: rawExpansion < 0.95,
                      child: Opacity(
                        opacity: expansion,
                        child: _buildDetailsCard(currentMember),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 8,
                    child: IgnorePointer(
                      ignoring: closeOpacity == 0,
                      child: Opacity(
                        opacity: closeOpacity,
                        child: IconButton(
                          onPressed: _collapseDetails,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 36,
                          ),
                          tooltip: 'Swipe down to close details',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20 + _hintOffset.value,
                    child: IgnorePointer(
                      ignoring: hintOpacity == 0,
                      child: Opacity(
                        opacity: hintOpacity,
                        child: GestureDetector(
                          onTap: _expandDetails,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: Colors.black12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1E000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Swipe up for details',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 28,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}