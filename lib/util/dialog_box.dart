import 'package:flutter/material.dart';
import 'package:streak_keeper/util/buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.black87,
          width: 1,
        ),
      ),
      content: SizedBox(
        height: 115,
        width: 300,
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLength: 30,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green[50],
                hintText: hintText,
                counterText: "", // hides the character counter
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 9),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 110,
                  child: TextButton(
                    onPressed: onSave,
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black54,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 110,
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black54,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}