import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDeleteDialog extends StatelessWidget{
  const HotelDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete hotel !'),
      content: const Text('Are you sure you want to delete this hotel ?'),
      actions: [
        ElevatedButton(
            onPressed:
              () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text(
              'No',
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
              ),
            ),
        ),
        ElevatedButton(
          onPressed:
              () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Yes',
            style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }
}