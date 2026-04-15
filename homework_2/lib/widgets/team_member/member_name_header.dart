import 'package:flutter/material.dart';

import '../../models/member.dart';

class MemberNameHeader extends StatelessWidget {
  final Member member;

  const MemberNameHeader({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
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
}
