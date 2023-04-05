import 'package:Nimbus/template/colors/AppColors.dart';
import 'package:Nimbus/template/colors/AppColorsDark.dart';
import 'package:Nimbus/template/dimensions/AppDimensions.dart';
import 'package:Nimbus/template/strings/SpanishStrings.dart';
import 'package:Nimbus/template/strings/Strings.dart';
import 'package:flutter/cupertino.dart';

import 'fonts/AppFonts.dart';
import 'strings/EnglishStrings.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    print('HECTOR:' + locale.languageCode);
    switch (locale.languageCode) {
      case 'en':
        return EnglishStrings();
      case 'es':
        return SpanishStrings();
      default:
        return EnglishStrings();
    }
  }

  AppColors get color {
    return AppColors();
  }

  AppColorsDark get colorDark {
    return AppColorsDark();
  }

  AppDimensions get dimensions {
    return AppDimensions();
  }

  AppFonts get fonts {
    return AppFonts();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
