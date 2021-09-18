import 'package:s_utils/src/shared_prefs.dart';
import 'package:uni_links/uni_links.dart';

import 'models/setting.dart';

class UrlLink {

  static late Function redirectAction;

  static void incomingLinks() {
    handleInitialUri();
    uriLinkStream.listen((Uri? uri) {
      handleUrl(uri);
    }, onError: (Object err) {
      print('got err: $err');
    });
  }

  static Future<void> handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) {
        print('no initial uri');
      } else {
        handleUrl(uri);
      }
    } catch (e) {
      // Platform messages may fail but we ignore the exception
      print('failed to get initial uri');
      throw e;
    }
  }

  static void handleUrl(Uri? uri) {
    if (SSetting.config['version'] == null) {
      SharedPrefs.putString("link_url", uri.toString());
      return;
    }

    // 先移除link url 缓存
    SharedPrefs.remove("link_url");
    redirectAction(uri);
  }

}
