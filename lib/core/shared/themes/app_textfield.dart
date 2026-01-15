part of 'themes.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final Widget? suffixLabel;
  final String? hint;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final bool obscureText;
  final bool multiLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final InputBorder? customBorder;
  final InputBorder? customFocusedBorder;
  final bool? enable;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const AppTextField({
    super.key,
    this.label,
    this.suffixLabel,
    this.hint,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.obscureText = false,
    this.multiLines = false,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.customBorder,
    this.customFocusedBorder,
    this.enable,
    this.onTap,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          enabled: enable,
          controller: controller,
          style: textStyle ?? appFonts.ts,
          cursorColor: appColors.primary,
          obscureText: obscureText,
          maxLines: multiLines ? 5 : 1,
          validator: validator,
          keyboardType: keyboardType,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? appColors.surfaceBg,
            hoverColor: hoverColor,
            focusColor: focusColor,
            label: label != null
                ? Text(label!, style: appFonts.white.ts)
                : null,
            labelStyle: appFonts.white.ts,
            hintText: hint,
            hintStyle: appFonts.ts.copyWith(color: appColors.neutral[40]),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            border: customBorder ?? border,
            enabledBorder: customBorder ?? border,
            focusedBorder: customFocusedBorder ?? focusedBorder,
            errorBorder: errorBorder,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorStyle: appFonts.caption.error.ts,
          ),
        ),
      ],
    );
  }

  InputBorder get border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: appColors.neutral[50]!),
    );
  }

  InputBorder get focusedBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: appColors.primary),
    );
  }

  InputBorder get errorBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: appColors.error),
    );
  }
}
