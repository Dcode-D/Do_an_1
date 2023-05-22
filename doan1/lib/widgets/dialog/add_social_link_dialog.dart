import 'package:flutter/material.dart';

class AddSocialDialog extends Dialog{
  Function addSocial;

  AddSocialDialog({required this.addSocial});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        height: 200,
        width: 450,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            const Text("Add your social network link.",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Add URL',
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: 'oh',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0.3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Cancel",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addSocial();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Add",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
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