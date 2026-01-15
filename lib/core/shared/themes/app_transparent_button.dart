part of 'themes.dart';

class AppTransparentButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  const AppTransparentButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(onTap: onTap, child: child),
      ),
    );
  }
}
