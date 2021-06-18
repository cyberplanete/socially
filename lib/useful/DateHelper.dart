import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  String MyDate(int timeStamp) {
    initializeDateFormatting();
    DateTime now = DateTime.now();
    DateTime timePost = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    DateFormat format;
    if (now.difference(timePost).inDays > 0) {
      format = new DateFormat.yMMMd("fr_FR").add_Hm();
    } else {
      format = new DateFormat.Hm("fr_FR");
    }
    return format.format(timePost).toString();
  }
}
