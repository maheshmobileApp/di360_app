import 'package:jiffy/jiffy.dart';

String jiffyDataWidget(String date,{String? format}) {
  return date == ''
      ? ''
      : format != ''
          ? Jiffy.parse(date).format(pattern: format)
          : Jiffy.parse(date).fromNow();
}