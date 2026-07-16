import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:streak_keeper/data/journey_database.dart';
import 'package:streak_keeper/util/today_tile.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final myBox = Hive.box("mybox");
  JourneyDatabase db = JourneyDatabase();

  bool showSwipeHint = true;

  @override
  void initState() {
    db.loadData();

    showSwipeHint = !(myBox.get("SWIPE_HINT_SHOWN") ?? false);

    super.initState();
  }


  void completeGoal(int index) {
    setState(() {

      if (!db.goalList[index][1]) {

        db.goalList[index][1] = true;

        db.goalList[index][2]++;

        if (db.goalList[index][2] > db.goalList[index][3]) {
          db.goalList[index][3] = db.goalList[index][2];
        }


        // Hide swipe hint after first completion
        if (showSwipeHint) {
          showSwipeHint = false;
          myBox.put("SWIPE_HINT_SHOWN", true);
        }


        db.updateDatabase();
      }

    });
  }


  @override
  Widget build(BuildContext context) {

    final pendingGoals =
    db.goalList.where((goal) => goal[1] == false).toList();


    return Scaffold(

      backgroundColor: Colors.green[50],

      appBar: AppBar(
        title: Text(
          "Today's Goals",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      body: pendingGoals.isEmpty

          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Image.asset(
              "assets/icon/icons.png",
              height: 150,
            ),

            const SizedBox(height: 20),

            Text(
              "All tasks completed!",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Amazing work! Come back tomorrow to continue your journey.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),

          ],
        ),
      )


          : Column(
        children: [

          if (showSwipeHint)
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 5,
              ),

              child: Text(
                "← Swipe left to mark as done",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),


          Expanded(
            child: ListView.builder(

              itemCount: pendingGoals.length,

              itemBuilder: (context, index) {

                return TodayTile(

                  goalName: pendingGoals[index][0],

                  completedToday:
                  pendingGoals[index][1],

                  doneFunction: (context) {

                    int originalIndex =
                    db.goalList.indexOf(
                        pendingGoals[index]
                    );

                    completeGoal(originalIndex);

                  },
                );

              },
            ),
          ),

        ],
      ),
    );
  }
}