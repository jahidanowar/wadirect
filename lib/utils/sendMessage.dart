import 'package:directwp/utils/trimWhiteSpaces.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> sendMessage({number, message}) async {
  number = trimWhiteSpaces(number);
  String wpUrl = "https://wa.me/$number?text=$message";
  String encodedUrl = Uri.encodeFull(wpUrl);
  //Save data to database
  if (await canLaunch(encodedUrl)) {
    return launch(encodedUrl);
  }
  return false;
}
