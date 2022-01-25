import 'package:intl/intl.dart';

String formatTimeStamp(int timestamp) {
  DateFormat formatter = new DateFormat('d/MM/yyy hh:mm a');

  return formatter.format(new DateTime.fromMillisecondsSinceEpoch(timestamp));
}
