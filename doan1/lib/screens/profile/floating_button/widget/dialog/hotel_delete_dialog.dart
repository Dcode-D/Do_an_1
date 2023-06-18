import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDeleteDialog extends StatelessWidget{

  Function deleteHotel;
  HotelDeleteDialog({required this.deleteHotel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete hotel !'),
      content: const Text('Are you sure you want to delete this hotel ?'),
      actions: [
        ElevatedButton(
            onPressed:
              () => Navigator.pop(context),
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
              () => deleteHotel(),
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