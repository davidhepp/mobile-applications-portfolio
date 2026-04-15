import 'package:flutter/material.dart';

import '../../models/member.dart';
import 'member_presentation.dart';

class MemberDetailsCard extends StatelessWidget {
  final Member member;
  final VoidCallback onCollapse;

  const MemberDetailsCard({
    super.key,
    required this.member,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    final String country = MemberPresentation.country(member);
    final String countryFlag = MemberPresentation.countryFlag(country);
    final Color accent = MemberPresentation.accent(member);
    final List<Color> cardGradient = MemberPresentation.cardGradient(member);
    final String universityLabel = MemberPresentation.universityLabel(member);

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
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.1),
          boxShadow: [
            const BoxShadow(
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
                  onTap: onCollapse,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
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
              _MemberInfoRow(
                leading: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Colors.black54,
                ),
                label: 'INTRO',
                value: member.intro,
              ),
              _MemberInfoRow(
                leading: Text(
                  countryFlag,
                  style: const TextStyle(fontSize: 20, height: 1.0),
                ),
                label: 'HOME COUNTRY',
                value: country,
              ),
              _MemberInfoRow(
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
}

class _MemberInfoRow extends StatelessWidget {
  final Widget leading;
  final String label;
  final String value;

  const _MemberInfoRow({
    required this.leading,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
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
}
