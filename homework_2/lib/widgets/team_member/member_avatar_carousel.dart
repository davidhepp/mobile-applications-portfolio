import 'package:flutter/material.dart';

import '../../models/member.dart';
import 'member_presentation.dart';

class MemberAvatarCarousel extends StatelessWidget {
  final List<Member> members;
  final PageController pageController;
  final Animation<double> expandController;
  final int initialPage;
  final ValueChanged<int> onPageChanged;
  final double Function(double from, double to, double t) lerp;

  const MemberAvatarCarousel({
    super.key,
    required this.members,
    required this.pageController,
    required this.expandController,
    required this.initialPage,
    required this.onPageChanged,
    required this.lerp,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 200;

    return PageView.builder(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final int realIndex = index % members.length;
        final Member member = members[realIndex];
        final Color accent = MemberPresentation.accent(member);

        return AnimatedBuilder(
          animation: Listenable.merge([pageController, expandController]),
          builder: (context, child) {
            double value = 1.0;

            if (pageController.hasClients &&
                pageController.position.haveDimensions &&
                pageController.page != null) {
              value = pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            } else {
              value = index == initialPage ? 1.0 : 0.0;
            }

            final double expansion = Curves.easeOutCubic.transform(
              expandController.value,
            );
            final double avatarScaleShrink = lerp(1.0, 0.76, expansion);
            final double opacity = 0.5 + (0.5 * value);
            final double scale = 0.6 + (0.4 * value);

            return Center(
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale * avatarScaleShrink,
                  child: child,
                ),
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              final int targetPage =
                  pageController.page?.round() ?? initialPage;
              if (index != targetPage) {
                pageController.animateToPage(
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
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFEDE6F8),
                      alignment: Alignment.center,
                      child: Text(
                        MemberPresentation.initials(member.name),
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
}
