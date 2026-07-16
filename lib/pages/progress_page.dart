import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:streak_keeper/data/journey_database.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final myBox = Hive.box("mybox");
  JourneyDatabase db = JourneyDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],

      appBar: AppBar(
        title: Text(
          "Progress",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: db.goalList.isEmpty
          ? Center(
        child: Text(
          "No goals yet 🌱",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      )

          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: db.goalList.length,

        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 4,
            color: Colors.green[100],

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),

              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),

                childrenPadding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  18,
                  18,
                ),

                iconColor: Colors.green[700],
                collapsedIconColor: Colors.green[700],

                title: Text(
                  db.goalList[index][0],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.green[700],
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Current Streak : ${db.goalList[index][2]}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.green[700],
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Best Streak : ${db.goalList[index][3]}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        db.goalList[index][1]
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,

                        color: Colors.green[700],
                      ),

                      const SizedBox(width: 10),

                      Text(
                        db.goalList[index][1]
                            ? "Completed Today"
                            : "Pending Today",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}