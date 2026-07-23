import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<bool> launchExternalUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
