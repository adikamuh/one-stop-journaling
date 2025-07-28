import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';

class AppCircleButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  const AppCircleButton({super.key, required this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Material(
            shape: const CircleBorder(),
            color: appColors.neutral[40],
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  icon,
                  color: appColors.white,
                  size: 28,
                ),
              ),
            ),
          ),
          if (text != null) const SizedBox(height: 8),
          if (text != null)
            Text(
              text!,
              style: appFonts.caption.white.ts,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
