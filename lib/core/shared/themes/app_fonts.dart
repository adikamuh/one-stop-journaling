part of 'themes.dart';

class AppFonts {
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;

  AppFonts._({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.decoration,
    this.fontStyle,
  });

  AppFonts copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return AppFonts._(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  TextStyle get ts {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize ?? _body.fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? text.color,
      letterSpacing: 0,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  List<TextStyle> get tsList {
    return [
      GoogleFonts.plusJakartaSans(
        fontSize: fontSize ?? _body.fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? text.color,
        letterSpacing: 0,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
      GoogleFonts.notoSerifGeorgian(
        fontSize: fontSize ?? _body.fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? text.color,
        letterSpacing: 0,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
      GoogleFonts.merriweather(
        fontSize: fontSize ?? _body.fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? text.color,
        letterSpacing: 0,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
    ];
  }

  /// Color
  AppFonts customColor(Color color) {
    return copyWith(color: color);
  }

  AppFonts get placeholder {
    return copyWith(color: appColors.background);
  }

  AppFonts get text {
    return copyWith(color: appColors.white);
  }

  AppFonts get light {
    return copyWith(color: appColors.lightFont);
  }

  AppFonts get gray {
    return copyWith(color: appColors.grayFont);
  }

  AppFonts get disabled {
    return copyWith(color: appColors.disabledButtonFont);
  }

  AppFonts get primary {
    return copyWith(color: appColors.primary);
  }

  AppFonts get secondary {
    return copyWith(color: appColors.secondary);
  }

  AppFonts get white {
    return copyWith(color: appColors.white);
  }

  AppFonts get black {
    return copyWith(color: appColors.black);
  }

  AppFonts get info {
    return copyWith(color: appColors.info);
  }

  AppFonts get success {
    return copyWith(color: appColors.success);
  }

  AppFonts get warning {
    return copyWith(color: appColors.warning);
  }

  AppFonts get error {
    return copyWith(color: appColors.error);
  }

  /// Decoration
  AppFonts customWeight(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }

  AppFonts get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  AppFonts get semibold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  AppFonts get underline {
    return copyWith(decoration: TextDecoration.underline);
  }

  AppFonts get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }

  /// Font Size
  AppFonts customSize(double fontSize) {
    return copyWith(fontSize: fontSize);
  }

  AppFonts get captionSmall {
    return copyWith(fontSize: 8);
  }

  AppFonts get caption {
    return copyWith(fontSize: 12);
  }

  AppFonts get _body {
    return copyWith(fontSize: 14);
  }

  AppFonts get subtitle {
    return copyWith(fontSize: 18);
  }

  AppFonts get titleSmall {
    return copyWith(fontSize: 24);
  }

  AppFonts get title {
    return copyWith(fontSize: 32);
  }
}

///
/// Example: appFonts.title.ts
///

AppFonts get appFonts {
  return AppFonts._();
}
