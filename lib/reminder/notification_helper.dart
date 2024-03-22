import 'dart:math';

class NotificationHelper {
  static List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];

    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }

    return ids;
  }

  static Map<String, List<String>> generateIDs(int selectedIntervals) {
    List<int> intIDs = makeIDs(24 / selectedIntervals);
    List<String> stringIntIDs = intIDs.map((i) => i.toString()).toList();
    List<String> notificationIDs = stringIntIDs.toList();
    return {
      'intIDs': stringIntIDs,
      'notificationIDs': notificationIDs,
    };
  }
}
