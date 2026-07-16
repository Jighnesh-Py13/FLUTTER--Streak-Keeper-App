import 'package:hive/hive.dart';

class JourneyDatabase {
  List goalList = [];

  final _myBox = Hive.box("mybox");

  void createInitialData() {
    goalList = [];

    // Save today's date when the app is first used
    _myBox.put("LAST_OPEN_DATE", _today());

    updateDatabase();
  }

  void loadData() {
    goalList = _myBox.get("GOALLIST") ?? [];

    checkForNewDay();
  }

  void updateDatabase() {
    _myBox.put("GOALLIST", goalList);
  }

  String _today() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  void checkForNewDay() {
    String today = _today();

    String? lastDate = _myBox.get("LAST_OPEN_DATE");

    // First launch
    if (lastDate == null) {
      _myBox.put("LAST_OPEN_DATE", today);
      return;
    }

    // Same day -> do nothing
    if (lastDate == today) {
      return;
    }

    // New day
    for (int i = 0; i < goalList.length; i++) {
      if (goalList[i][1] == true) {
        // Completed yesterday
        goalList[i][1] = false;
      } else {
        // Missed yesterday
        goalList[i][2] = 0;
      }
    }

    _myBox.put("LAST_OPEN_DATE", today);

    updateDatabase();
  }
}