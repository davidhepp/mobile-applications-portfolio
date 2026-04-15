import 'package:flutter/material.dart';
import 'settings_tile.dart';

class LanguageTile extends StatefulWidget {
  const LanguageTile({super.key});

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Language',
      icon: Icons.language,
      onTap: () {},
      children: ['English', 'German', 'Finnish'].map((lang) {
        final isSelected = lang == _selectedLanguage;
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedLanguage = lang;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.deepPurple.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      lang,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.deepPurple.shade700
                            : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.deepPurple.shade700,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
