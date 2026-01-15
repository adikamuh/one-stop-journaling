part of 'helper.dart';

class SnackbarHelper {
  static Widget _baseSnacky({
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(text, style: appFonts.caption.copyWith(color: textColor).ts),
    );
  }

  static void success(String text) {
    final snacky = Snacky.widget(
      location: SnackyLocation.top,
      builder: (context, cancelableSnacky) {
        return _baseSnacky(
          text: text,
          backgroundColor: appColors.success,
          textColor: Colors.white,
        );
      },
    );
    SnackyController.instance.showMessage((context) => snacky);
  }

  static void error(String text) {
    final snacky = Snacky.widget(
      location: SnackyLocation.top,
      builder: (context, cancelableSnacky) {
        return _baseSnacky(
          text: text,
          backgroundColor: appColors.error,
          textColor: Colors.white,
        );
      },
    );
    SnackyController.instance.showMessage((context) => snacky);
  }
}
