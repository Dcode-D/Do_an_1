import 'dart:ffi';

class Hotel{
  String id;
  String imageUrl;
  String name;
  String address;
  String description;
  String type;
  String price;
  List<String> imageUrls = [];

  Hotel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.description,
    required this.type,
    required this.price,
    required this.imageUrls,
  });
}

//Note: This is a dummy data for testing purpose
List<Hotel> hotels = [
  Hotel(
    id: '1',
    imageUrl: 'assets/images/hotel0.jpg',
    name: 'Hotel 0',
    address: '404 Great St',
    description: 'Hotel 0 description',
    type: 'Hotel',
    price: '175',
    imageUrls: [
      'assets/images/hotel0.jpg',
      'assets/images/hotel1.jpg',
      'assets/images/hotel2.jpg',
    ],
  ),
  Hotel(
    id: '2',
    imageUrl: 'assets/images/hotel1.jpg',
    name: 'Hotel 1',
    address: '404 Great St',
    description: 'Hotel 1 description',
    type: 'Hotel',
    price: '300',
    imageUrls: [
      'assets/images/hotel0.jpg',
      'assets/images/hotel1.jpg',
      'assets/images/hotel2.jpg',
    ],
  ),
  Hotel(
    id: '3',
    imageUrl: 'assets/images/hotel2.jpg',
    name: 'Hotel 2',
    address: '404 Great St',
    description: 'Hotel 2 description',
    type: 'Hotel',
    price: '240',
    imageUrls: [
      'assets/images/hotel0.jpg',
      'assets/images/hotel1.jpg',
      'assets/images/hotel2.jpg',
    ],
  ),
];
