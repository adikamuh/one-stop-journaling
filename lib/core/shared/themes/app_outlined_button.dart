part of 'themes.dart';

class AppOutlinedButton extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Function()? onTap;
  final bool isDisabled;
  final String? text;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? customIconColor;
  final IconData? suffixIcon;
  final double adjustIconSize;
  final Widget? child;
  final AppButtonType type;
  final bool isFitParent;
  final Color? backgroundColor;
  final EdgeInsets? customPadding;

  const AppOutlinedButton({
    super.key,
    this.color,
    this.borderColor,
    this.type = AppButtonType.normal,
    this.onTap,
    this.isDisabled = false,
    this.icon,
    this.customIconColor,
    this.suffixIcon,
    this.adjustIconSize = 0,
    this.text,
    this.textStyle,
    this.child,
    this.isFitParent = false,
    this.backgroundColor,
    this.customPadding,
  }) : assert(child != null || text != null || icon != null);

  double get borderRadius => 8;

  EdgeInsets? get padding {
    if (icon != null && text == null) {
      switch (type) {
        case AppButtonType.normal:
          return const EdgeInsets.all(8);
        case AppButtonType.big:
          return const EdgeInsets.all(10);
        case AppButtonType.small:
          return const EdgeInsets.all(8);
      }
    } else {
      switch (type) {
        case AppButtonType.normal:
          return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
        case AppButtonType.big:
          return const EdgeInsets.symmetric(horizontal: 18, vertical: 8);
        case AppButtonType.small:
          return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      }
    }
  }

  double get iconSize {
    switch (type) {
      case AppButtonType.small:
        return appFonts.caption.ts.fontSize! + 1 + adjustIconSize;
      default:
        return appFonts.ts.fontSize! + 1 + adjustIconSize;
    }
  }

  Color? get iconColor {
    if (customIconColor != null) return customIconColor;

    if (isDisabled) {
      return appColors.disabledButtonFont;
    } else {
      return appColors.white;
    }
  }

  TextStyle get ts {
    if (isDisabled) {
      switch (type) {
        case AppButtonType.small:
          return appFonts.caption.disabled.ts;
        default:
          return appFonts.disabled.ts;
      }
    } else {
      switch (type) {
        case AppButtonType.small:
          return appFonts.caption.white.ts;
        default:
          return textStyle ?? appFonts.white.ts;
      }
    }
  }

  MaterialColor? get materialColor {
    return (isDisabled)
        ? null
        : (color != null
              ? (color is MaterialColor)
                    ? (color as MaterialColor)
                    : null
              : appColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: isDisabled
              ? appColors.disabledButton
              : (borderColor ?? appColors.border),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onTap?.call(),
        borderRadius: BorderRadius.circular(borderRadius),
        hoverColor: materialColor?.hover,
        focusColor: materialColor?.hover,
        highlightColor: materialColor?.pressed,
        child: buttonChild,
      ),
    );
  }

  Widget get buttonChild {
    return Container(
      padding: customPadding ?? padding,
      child: (child != null)
          ? child
          : Row(
              mainAxisSize: isFitParent ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: iconSize, color: iconColor),
                ],
                if (text != null && icon != null) ...[const SizedBox(width: 8)],
                if (text != null) ...[Flexible(child: Text(text!, style: ts))],
                if (text != null && suffixIcon != null) ...[
                  const SizedBox(width: 8),
                ],
                if (suffixIcon != null) ...[
                  Icon(suffixIcon, size: iconSize - 2, color: iconColor),
                ],
              ],
            ),
    );
  }
}
