import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDeleteDialog extends StatelessWidget{
  VehicleDeleteDialog({required this.deleteVehicle});

  Function deleteVehicle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete vehicle !'),
      content: const Text('Are you sure you want to delete this vehicle ?'),
      actions: [
        ElevatedButton(
          onPressed:
              () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text(
            'No',
            style: GoogleFonts.raleway(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500
            )
          ),
        ),
        ElevatedButton(
          onPressed:
              () => deleteVehicle(),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Yes',
            style: GoogleFonts.raleway(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500
            )
          ),
        ),
      ],
    );
  }
}