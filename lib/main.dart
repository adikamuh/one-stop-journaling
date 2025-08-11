import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:one_stop_journaling/core/di/injectors.dart';
import 'package:one_stop_journaling/core/services/isar_service.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/home/presentations/home_screen.dart';
import 'package:snacky/snacky.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  initCoreDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: appColors.black.withValues(alpha: 0.5),
      overlayWidgetBuilder: (_) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: appColors.black,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CircularProgressIndicator(color: appColors.primary),
          ),
        );
      },
      child: SnackyConfiguratorWidget(
        app: MaterialApp(
          home: const HomeScreen(),
          navigatorObservers: [SnackyNavigationObserver()],
        ),
      ),
    );
  }
}
