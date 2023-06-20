import 'package:flutter/material.dart';

class DeletePostDialog extends StatelessWidget{
  Function deletePost;
  DeletePostDialog({required this.deletePost});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete post !'),
      content: const Text('Are you sure you want to delete this post ?'),
      actions: [
        ElevatedButton(
          onPressed:
              () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: const Text(
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
              () => deletePost(),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: const Text(
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