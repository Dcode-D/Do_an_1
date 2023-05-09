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
List<Tour> tours = [
  Tour(
    id: 't0',
    img: 'assets/images/tour0.jpg',
    name: 'Tour 0',
    description: 'Tour 0 description',
    destinationIDs: '1,2,3',
    price: '1000',
    profit: '100',
    ratingList: comments,
    status: 1,
  ),
  Tour(
    id: 't1',
    img: 'assets/images/tour1.jpg',
    name: 'Tour 1',
    description: 'Tour 1 description',
    destinationIDs: '1,2,3',
    price: '1000',
    profit: '100',
    ratingList: comments,
    status: 1,
  ),
  Tour(
    id: 't2',
    img: 'assets/images/tour2.jpg',
    name: 'Tour 2',
    description: 'Tour 2 description',
    destinationIDs: '1,2,3',
    price: '1000',
    profit: '100',
    ratingList: comments,
    status: 1,
  ),

];