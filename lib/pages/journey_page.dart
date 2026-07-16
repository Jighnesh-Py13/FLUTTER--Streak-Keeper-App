import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:streak_keeper/data/journey_database.dart';
import 'package:streak_keeper/util/dialog_box.dart';
import 'package:streak_keeper/util/journey_tile.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}


class _JourneyPageState extends State<JourneyPage> {

  final myBox = Hive.box("mybox");

  JourneyDatabase db = JourneyDatabase();

  final _controller = TextEditingController();

  bool showJourneyHint = true;


  @override
  void initState() {

    if (myBox.get("GOALLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    showJourneyHint =
    !(myBox.get("JOURNEY_HINT_SHOWN") ?? false);

    super.initState();
  }



  void saveNewGoal() {

    String newGoal = _controller.text.trim();


    if (newGoal.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Goal must be at least 3 characters."),
        ),
      );
      return;
    }


    bool alreadyExists = db.goalList.any(
          (goal) =>
      goal[0].toString().toLowerCase() ==
          newGoal.toLowerCase(),
    );


    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This goal already exists."),
        ),
      );
      return;
    }


    setState(() {

      db.goalList.add([
        newGoal,
        false,
        0,
        0,
      ]);

      db.updateDatabase();

      _controller.clear();

      Navigator.pop(context);

    });

  }



  void updateGoal(int index) {

    String updatedGoal = _controller.text.trim();


    if (updatedGoal.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Goal must be at least 3 characters."),
        ),
      );
      return;
    }


    bool alreadyExists =
    db.goalList.asMap().entries.any(
          (entry) =>
      entry.key != index &&
          entry.value[0].toString().toLowerCase() ==
              updatedGoal.toLowerCase(),
    );


    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Another goal already has this name."),
        ),
      );
      return;
    }


    setState(() {

      db.goalList[index][0] = updatedGoal;

      db.updateDatabase();


      if (showJourneyHint) {
        showJourneyHint = false;
        myBox.put("JOURNEY_HINT_SHOWN", true);
      }


      _controller.clear();

      Navigator.pop(context);

    });

  }



  void cancel() {
    _controller.clear();
    Navigator.pop(context);
  }



  void createNewGoal() {

    _controller.clear();


    showDialog(
      context: context,
      builder: (context) {

        return DialogBox(
          controller: _controller,
          hintText: "New Goal",
          onSave: saveNewGoal,
          onCancel: cancel,
        );

      },
    );

  }



  void deleteGoal(int index) {

    setState(() {

      db.goalList.removeAt(index);

      db.updateDatabase();


      if (showJourneyHint) {
        showJourneyHint = false;
        myBox.put("JOURNEY_HINT_SHOWN", true);
      }

    });

  }



  void editGoal(int index) {

    _controller.text = db.goalList[index][0];


    showDialog(
      context: context,
      builder: (context) {

        return DialogBox(
          controller: _controller,
          hintText: "Edit Goal",
          onSave: () => updateGoal(index),
          onCancel: cancel,
        );

      },
    );

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.green[50],


      appBar: AppBar(

        title: Text(
          "My Journey",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),


      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.teal[600],

        onPressed: createNewGoal,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

      ),



      body: db.goalList.isEmpty

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
              "Your journey starts here 🌱",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 10),


            Text(
              "Tap the + button to add your first goal.",
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),

          ],

        ),
      )


          : Column(

        children: [


          if (showJourneyHint)

            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 5,
              ),

              child: Text(
                "← Swipe to edit     Swipe to delete →",

                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),

              ),

            ),



          Expanded(

            child: ListView.builder(

              itemCount: db.goalList.length,


              itemBuilder: (context, index) {

                return JourneyTile(

                  goalName: db.goalList[index][0],

                  deleteFunction: (context) =>
                      deleteGoal(index),

                  editFunction: (context) =>
                      editGoal(index),

                );

              },

            ),

          ),

        ],

      ),

    );

  }

}