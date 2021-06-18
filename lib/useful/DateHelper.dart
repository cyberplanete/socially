import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

///Class modifiant une date en milliseconds vers DDMMYY + heure minutes ou en heure minutes si post crée dans la journée
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
