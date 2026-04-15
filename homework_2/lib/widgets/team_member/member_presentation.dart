import 'package:flutter/material.dart';

import '../../models/member.dart';

class MemberPresentation {
  // Team note: Keep `homeCountry` updated with a real country name (or
  // a 2-letter ISO code like FI). The flag in the details panel updates
  // automatically from that value.
  static const Map<String, String> _countryNameToIso = {
    'afghanistan': 'AF',
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

  // Member defaults. If others update `homeCountry`, their flags
  // will come from that field automatically.
  static const Map<String, String> _memberCountryOverrides = {
    'David': 'Germany',
    'Shayan Khurram': 'Pakistan',
    'Ayesha Siddiqua': 'Bangladesh',
    'Reza Mesbah': 'Afganistan',
    
  };

  static String initials(String name) {
    final List<String> parts = name
        .split(' ')
        .where((String part) => part.trim().isNotEmpty)
        .toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  static String country(Member member) {
    final String country =
        _memberCountryOverrides[member.name] ?? member.homeCountry;
    return country.trim();
  }

  static String countryFlag(String countryOrIso) {
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

  static bool isDavid(Member member) {
    return member.name.trim().toLowerCase() == 'david';
  }

  static List<Color> cardGradient(Member member) {
    if (isDavid(member)) {
      return const [Color(0xFFFFF2E4), Color(0xFFFFD9B0)];
    }

    return const [Color(0xFFF6F0FF), Color(0xFFE8D9FF)];
  }

  static Color accent(Member member) {
    if (isDavid(member)) {
      return const Color(0xFFEF7A24);
    }

    return const Color(0xFF6F38D6);
  }

  static List<Color> backdrop(Member member) {
    if (isDavid(member)) {
      return const [Color(0xFFFFFBF6), Color(0xFFFFF0DE)];
    }

    return const [Color(0xFFFDFBFF), Color(0xFFF2EAFF)];
  }

  static String universityLabel(Member member) {
    if (isDavid(member)) {
      return 'THWS Germany';
    }

    return 'TAMK Finland';
  }
}
