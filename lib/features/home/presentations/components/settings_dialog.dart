import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  String version = "";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  void _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = "${packageInfo.version}+${packageInfo.buildNumber}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: appColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Text("One Stop Journaling", style: appFonts.subtitle.semibold.ts),
            Text("Version: $version", style: appFonts.caption.ts),
            Text(
              "Inspired by Matthew Dicks’ Homework for Life, this app helps you capture the essence of each day in just one sentence. With a clean, minimalist design, it encourages reflection and daily storytelling — one day, one line at a time. \nThe app is completely free and ad-free, kept simple by choice, and supported through optional donations. I’m also open to any suggestions to help improve this app.",
              style: appFonts.ts,
              textAlign: TextAlign.justify,
            ),
            _buildOption(
              title: "Privacy Policy",
              onTap: () {
                launchUrl(
                  Uri.parse("https://one-stop-journaling-policy.vercel.app/"),
                );
              },
            ),
            _buildOption(
              title: 'Donate us',
              onTap: () {
                launchUrl(Uri.parse("https://ko-fi.com/adikamuh"));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appColors.primary)),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: appFonts.ts),
            Icon(Icons.chevron_right, color: appColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}
