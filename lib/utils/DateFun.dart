import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateFun {


  static getDOBFormat() {
    return "MM/dd/yyyy";
  }

  static getDateUKFormat() {
    return "dd/MM/yyyy";
  }

  static getDateBDFormat() {
    return "dd/MM/yyyy";
  }

  static String getStringFromDateTime(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt).toString();
  }

  static String getDateWhatsAppFormat(String dt) {
    try {
      DateTime checkedTime = DateTime.parse(dt);
      DateTime currentTime = DateTime.now();
      if ((currentTime.year == checkedTime.year) &&
          (currentTime.month == checkedTime.month) &&
          (currentTime.day == checkedTime.day)) {
        dt = Jiffy.parse(dt).format(pattern: "hh:mm a");
      } else {
        dt = Jiffy.parse(dt).format(pattern: "yyyy-MM-dd hh:mm a");
      }
    } catch (e) {}
    return dt;
  }

  static String getDate(String dt, String format) {
    if (dt.isEmpty) {
      return dt;
    }
    try {
      return Jiffy.parseFromDateTime(DateTime.parse(dt)).format(pattern: format);
    } catch (e) {
      try {
        DateTime d = convertToDateTime(dt, 'mm/dd/yyyy');
        return getStringFromDateTime(d);
      } catch (e) {}
    }
    return dt;
  }
  static DateTime convertToDateTime(String dt, String format) {
    return DateFormat(format).parse(dt);
  }




  static DateTime getDateByFormat(String dt) {
    try {
      return DateFormat("yyyy-MM-dd").parse(dt);
    } catch (_) {
      try {
        return DateFormat("MM/dd/yyyy").parse(dt);
      } catch (_) {
        try {
          return DateFormat("yyyy-MM-dd").parse(dt);
        } catch (_) {
          try {
            return DateFormat("dd/MMM/yyyy").parse(dt);
          } catch (_) {
            try {
              return DateFormat("yyyy-MM-dd").parse(dt);
            } catch (_) {
              try {
                return DateFormat("dd/MM/yyyy").parse(dt);
              } catch (_) {
                return DateTime.now();
              }
            }
          }
        }
      }
    }
  }
}
