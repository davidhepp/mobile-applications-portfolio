import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/member.dart';
import 'team_member/member_avatar_carousel.dart';
import 'team_member/member_details_card.dart';
import 'team_member/member_name_header.dart';
import 'team_member/member_presentation.dart';
import 'team_member/swipe_up_hint.dart';

class TeamMemberCarousel extends StatefulWidget {
  final List<Member> members;
  final Widget? topSection;

  const TeamMemberCarousel({super.key, required this.members, this.topSection});

  @override
  State<TeamMemberCarousel> createState() => _TeamMemberCarouselState();
}

class _TeamMemberCarouselState extends State<TeamMemberCarousel>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final int _initialPage;
  late final AnimationController _expandController;
  late final AnimationController _hintController;
  late final Animation<double> _hintOffset;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
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

    _hintOffset = Tween<double>(begin: 0, end: 6).animate(
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

  void _onVerticalDragUpdate(
    DragUpdateDetails details,
    double maxDragDistance,
  ) {
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
              final double expansion = Curves.easeOutCubic.transform(
                rawExpansion,
              );
              final double profileMotion = Curves.easeOutQuart.transform(
                rawExpansion,
              );
              final double panelMotion = Curves.easeOutExpo.transform(
                rawExpansion,
              );

              final Member currentMember = widget.members[_currentPage];
              final List<Color> backdropColors = MemberPresentation.backdrop(
                currentMember,
              );

              final double hintOpacity = (1 - (expansion * 1.8)).clamp(
                0.0,
                1.0,
              );
              final double scrimOpacity = (rawExpansion * 0.16).clamp(
                0.0,
                0.16,
              );
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
                  Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.topSection != null)
                          IgnorePointer(
                            ignoring: rawExpansion > 0.05,
                            child: widget.topSection!,
                          ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, innerConstraints) {
                              final double innerScreenHeight =
                                  innerConstraints.maxHeight;
                              final double carouselHeight = _lerp(
                                250,
                                215,
                                profileMotion,
                              );
                              final double carouselTop = _lerp(
                                24,
                                14,
                                profileMotion,
                              );
                              final double nameTop =
                                  carouselTop +
                                  carouselHeight +
                                  _lerp(34, 18, profileMotion);

                              final double basePanelTop = _lerp(
                                innerScreenHeight + 32,
                                innerScreenHeight * 0.20,
                                panelMotion,
                              );
                              final double minPanelTop =
                                  carouselTop + carouselHeight - 60;
                              final double panelTop = basePanelTop < minPanelTop
                                  ? minPanelTop
                                  : basePanelTop;

                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: carouselTop,
                                    left: 0,
                                    right: 0,
                                    child: IgnorePointer(
                                      ignoring: rawExpansion > 0.78,
                                      child: SizedBox(
                                        height: carouselHeight,
                                        child: child!,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: nameTop,
                                    left: 16,
                                    right: 16,
                                    child: Center(
                                      child: MemberNameHeader(
                                        member: currentMember,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -3000,
                                    bottom: -3000,
                                    left: -3000,
                                    right: -3000,
                                    child: IgnorePointer(
                                      ignoring: rawExpansion < 0.05,
                                      child: GestureDetector(
                                        onTap: _collapseDetails,
                                        child: Container(
                                          color: Colors.black.withValues(
                                            alpha: scrimOpacity,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: panelTop,
                                    left: 16,
                                    right: 16,
                                    bottom: 0,
                                    child: IgnorePointer(
                                      ignoring: rawExpansion < 0.95,
                                      child: Opacity(
                                        opacity: expansion,
                                        child: MemberDetailsCard(
                                          member: currentMember,
                                          onCollapse: _collapseDetails,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    right: 16,
                                    bottom: 20 + _hintOffset.value,
                                    child: IgnorePointer(
                                      ignoring: hintOpacity == 0,
                                      child: Opacity(
                                        opacity: hintOpacity,
                                        child: Center(
                                          child: SwipeUpHint(
                                            onTap: _expandDetails,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            child: MemberAvatarCarousel(
              members: widget.members,
              pageController: _pageController,
              expandController: _expandController,
              initialPage: _initialPage,
              onPageChanged: (int page) {
                HapticFeedback.selectionClick();
                setState(() {
                  _currentPage = page % widget.members.length;
                });
              },
              lerp: _lerp,
            ),
          ),
        );
      },
    );
  }
}
