import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayTile extends StatelessWidget {

  final String goalName;
  final Function(BuildContext)? doneFunction;
  final bool completedToday;

  const TodayTile({
    super.key,
    required this.goalName,
    required this.doneFunction,
    required this.completedToday,
  });


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 20,
      ),

      child: Slidable(

        endActionPane: ActionPane(
          motion: const StretchMotion(),

          children: [

            SlidableAction(
              onPressed: doneFunction,

              icon: Icons.local_fire_department,

              backgroundColor: Colors.green,

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),

          ],
        ),


        child: Container(

          padding: const EdgeInsets.all(23),

          decoration: BoxDecoration(

            color: Colors.green[100],

            borderRadius: BorderRadius.circular(12),

          ),


          child: Row(

            children: [

              Expanded(

                child: Text(

                  goalName,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: GoogleFonts.poppins(

                    fontSize: 19,

                    fontWeight: FontWeight.w500,

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }
}