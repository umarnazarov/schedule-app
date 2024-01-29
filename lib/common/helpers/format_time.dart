import 'package:intl/intl.dart';

formatTimePeriod(DateTime startTime, DateTime endTime) {
  String formattedStartTime = DateFormat('hh:mm a').format(startTime);
  String formattedEndTime = DateFormat('hh:mm a').format(endTime);

  String timeRange = '$formattedStartTime - $formattedEndTime';

  return timeRange;
}
