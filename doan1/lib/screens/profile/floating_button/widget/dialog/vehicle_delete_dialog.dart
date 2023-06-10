import 'package:flutter/material.dart';

class VehicleDeleteDialog extends StatelessWidget{
  const VehicleDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete vehicle !'),
      content: const Text('Are you sure you want to delete this vehicle ?'),
      actions: [
        ElevatedButton(
          onPressed:
              () => Navigator.of(context).pop(false),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text(
            'No',
            style: TextStyle(
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
            style: TextStyle(
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