import 'package:url_launcher/url_launcher.dart';

Future<bool> sendMessage({number, message}) async {
  String wpUrl = "https://wa.me/$number?text=$message";
  //Save data to database
  if (await canLaunch(wpUrl)) {
    return launch(wpUrl);
  }
  return false;
}
