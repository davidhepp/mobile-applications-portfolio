import 'package:flutter/material.dart';

import 'menu_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final compact = maxHeight < 760;
            final logoSectionHeight = (maxHeight * 0.105)
                .clamp(84.0, 106.0)
                .toDouble();
            final logoAssetWidth = (constraints.maxWidth * 0.90)
                .clamp(270.0, 360.0)
                .toDouble();
            final heroHeight = (maxHeight * 0.245)
                .clamp(140.0, 225.0)
                .toDouble();

            final horizontalPadding = compact ? 16.0 : 20.0;
            final contentWidth = constraints.maxWidth - horizontalPadding * 2;
            final topPadding = compact ? 14.0 : 24.0;
            final bodyFontSize = compact ? 11.0 : 12.0;
            final infoFontSize = compact ? 10.0 : 11.0;
            final buttonHeight = compact ? 50.0 : 56.0;
            final buttonFontSize = compact ? 16.0 : 18.0;
            final introSeparatorGap = compact ? 26.0 : 32.0;
            final contactIconSize = compact ? 26.0 : 30.0;
            final contactColumnGap = compact ? 14.0 : 18.0;
            final contactColumnWidth = ((contentWidth - contactColumnGap) / 2)
                .clamp(0.0, 162.0);
            final contactRowGap = compact ? 12.0 : 16.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: logoSectionHeight,
                  child: Center(
                    child: Transform.scale(
                      scale: 2.0,
                      child: ClipRect(
                        child: Align(
                          alignment: const Alignment(0, 0.05),
                          widthFactor: 0.66,
                          heightFactor: 0.36,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: logoAssetWidth,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heroHeight,
                  child: Image.asset(
                    'assets/images/hero.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFFCF8F3),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      topPadding,
                      horizontalPadding,
                      16,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: contactColumnWidth * 2 + contactColumnGap,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: contactColumnWidth,
                                  child: Column(
                                    children: [
                                      _ContactInfo(
                                        icon: Icons.location_on_outlined,
                                        fontSize: infoFontSize,
                                        iconSize: contactIconSize,
                                        lines: const [
                                          'Restaurant Street 1,',
                                          '11111 City',
                                          'Country',
                                        ],
                                      ),
                                      SizedBox(height: contactRowGap),
                                      _ContactInfo(
                                        icon: Icons.mail_outline,
                                        fontSize: infoFontSize,
                                        iconSize: contactIconSize,
                                        lines: const ['info@rest.com'],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: contactColumnGap),
                                SizedBox(
                                  width: contactColumnWidth,
                                  child: Column(
                                    children: [
                                      _ContactInfo(
                                        icon: Icons.access_time,
                                        fontSize: infoFontSize,
                                        iconSize: contactIconSize,
                                        lines: const [
                                          'Tu-Th 11-20',
                                          'Fr-Su 11-23',
                                          'Mondays closed',
                                        ],
                                      ),
                                      SizedBox(height: contactRowGap),
                                      _ContactInfo(
                                        icon: Icons.phone_outlined,
                                        fontSize: infoFontSize,
                                        iconSize: contactIconSize,
                                        lines: const [
                                          '+1 1234 567890',
                                          '(Available 8-16)',
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: compact ? 36 : 48),
                        Container(width: 259, height: 1, color: Colors.black),
                        SizedBox(height: introSeparatorGap),
                        SizedBox(
                          width: 260,
                          child: Text(
                            'Come in, slow down, and feel at home.\nEnjoy handcrafted coffee and fresh bakes, inspired by tradition and made with local ingredients',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: bodyFontSize,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: bodyFontSize * 0.01,
                            ),
                          ),
                        ),
                        SizedBox(height: introSeparatorGap),
                        Container(width: 150, height: 1, color: Colors.black),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: buttonHeight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const MenuPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC67C4E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: buttonFontSize * 0.01,
                                  ),
                                ),
                                child: const Text('Our Menu'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.icon,
    required this.lines,
    required this.fontSize,
    required this.iconSize,
  });

  final IconData icon;
  final List<String> lines;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: iconSize + 2,
          child: Icon(icon, color: Colors.black, size: iconSize),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            lines.join('\n'),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: fontSize * 0.01,
            ),
          ),
        ),
      ],
    );
  }
}
