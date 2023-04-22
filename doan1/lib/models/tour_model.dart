import 'comment_model.dart';

class Tour{
String id;
  String img;
  String name;
  String description;
  String destinationIDs;
  String price;
  String profit;
  List<Comment> ratingList;
  int status;

  Tour({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.destinationIDs,
    required this.price,
    required this.profit,
    required this.ratingList,
    required this.status,
  });

  List<String> get destinationIDList => destinationIDs.split(',');
}

//Note: This is a dummy data for testing purpose