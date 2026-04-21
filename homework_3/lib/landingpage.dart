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
          final logoSectionHeight =
            (maxHeight * 0.105).clamp(84.0, 106.0).toDouble();
          final logoAssetWidth =
            (constraints.maxWidth * 0.90).clamp(270.0, 360.0).toDouble();
          final heroHeight = (maxHeight * 0.245).clamp(140.0, 225.0).toDouble();

            final horizontalPadding = compact ? 16.0 : 20.0;
            final topPadding = compact ? 14.0 : 24.0;
            final bodyFontSize = compact ? 11.0 : 12.0;
            final infoFontSize = compact ? 10.0 : 11.0;
            final buttonHeight = compact ? 50.0 : 56.0;
            final buttonFontSize = compact ? 16.0 : 18.0;
            final sectionGapSmall = compact ? 16.0 : 22.0;
            final sectionGapMedium = compact ? 22.0 : 34.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               SizedBox(
                  height: logoSectionHeight, // Holds the physical space steady
                  child: Center(
                    child: Transform.scale(
                      scale: 2.0, // <--- Visually scales the logo up by 70%
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
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      topPadding,
                      horizontalPadding,
                      16,
                    ),
                    child: Column(
                      children: [
                        Container(width: 259, height: 1, color: Colors.black),
                        SizedBox(height: sectionGapSmall),
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
                        SizedBox(height: compact ? 12 : 16),
                        Container(width: 150, height: 1, color: Colors.black),
                        SizedBox(height: sectionGapMedium),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 112,
                              child: _ContactInfo(
                                icon: Icons.location_on_outlined,
                                fontSize: infoFontSize,
                                lines: const [
                                  'Restaurant Street 1,',
                                  '11111 City',
                                  'Country',
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 95,
                              child: _ContactInfo(
                                icon: Icons.phone_outlined,
                                fontSize: infoFontSize,
                                lines: const ['+1 1234 567890', '(Available 18-16)'],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 95,
                              child: _ContactInfo(
                                icon: Icons.access_time,
                                fontSize: infoFontSize,
                                lines: const ['Tu-Th 11-20', 'Fr-Su 11-23', 'Mondays closed'],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: compact ? 14 : 20),
                        SizedBox(
                          width: 200,
                          child: _ContactInfo(
                            icon: Icons.mail_outline,
                            fontSize: infoFontSize,
                            lines: const ['info@rest.com'],
                          ),
                        ),
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
  });

  final IconData icon;
  final List<String> lines;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(height: 6),
          Text(
            lines.join('\n'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: fontSize * 0.01,
            ),
          ),
        ],
      ),
    );
  }
}
