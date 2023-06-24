import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../BLOC/widget_item/rating_item/rating_item_bloc.dart';


class EditRatingBottomSheet extends StatefulWidget {
  final Function(double,String) callbackSubmitComment;

  const EditRatingBottomSheet({
    Key? key,
    required this.callbackSubmitComment,
  }) : super(key: key);

  @override
  State<EditRatingBottomSheet> createState() => _EditRatingBottomSheetState();
}

class _EditRatingBottomSheetState extends State<EditRatingBottomSheet> {

  final _commentController = TextEditingController();
  var _ratingPoint = 0.0;
  var _ratingText = "";
  late RatingItemBloc ratingItemBloc;

  @override
  void initState() {
    super.initState();
    ratingItemBloc = context.read<RatingItemBloc>();
    _ratingPoint = ratingItemBloc.rating!.rating!;
    _commentController.text = ratingItemBloc.rating!.comment!;
  }

  void ratingText() {
    switch (_ratingPoint.toInt()) {
      case 1:
        _ratingText = "Awful";
        return;
      case 2:
        _ratingText = "Bad";
        return;
      case 3:
        _ratingText = "Normal";
        return;
      case 4:
        _ratingText = "Good";
        return;
      case 5:
        _ratingText = "Excellent";
        return;
      default:
        _ratingText = "";
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Leave your rating",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.w600,
              fontSize: 30.0),
        ),
        const SizedBox(height: 20.0),
        SmoothStarRating(
          allowHalfRating: false,
          starCount: 5,
          color: Colors.amber,
          size: 30,
          spacing: 6,
          borderColor: Colors.amber,
          defaultIconData: FontAwesomeIcons.star,
          filledIconData: FontAwesomeIcons.solidStar,
          rating: _ratingPoint,
          onRatingChanged: (value) {
            setState(() {
              _ratingPoint = value;
              ratingText();
            });
          },
        ),
        const SizedBox(height: 10.0),
        Text(_ratingText),
        const SizedBox(height: 20.0),
        TextField(
          controller: _commentController,
          maxLines: null,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Comment',
          ),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(onPressed: (){
          widget.callbackSubmitComment(_ratingPoint, _commentController.text);
          Navigator.pop(context);
        },
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Submit",
                style: GoogleFonts.roboto(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4.0),
              const Icon(
                FontAwesomeIcons.locationArrow,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
