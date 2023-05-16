
class Hotel{
  String id;
  String imageUrl;
  String name;
  String address;
  String description;
  List<String> hotelFacilities = [];
  String price;
  List<String> imageUrls = [];

  Hotel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.description,
    required this.hotelFacilities,
    required this.price,
    required this.imageUrls,
  });
}

//Note: This is a dummy data for testing purpose
List<Hotel> hotels = [
  Hotel(
    id: 'h0',
    imageUrl: 'assets/images/hotel0.jpg',
    name: 'Hotel 0',
    address: '404 Great St',
    description: 'Hotel 0 description',
    hotelFacilities: ['Wifi', 'Pool'],
    price: '175',
    imageUrls: [
      'assets/images/hotel0.jpg',
      'assets/images/hotel1.jpg',
      'assets/images/hotel2.jpg',
    ],
  ),
  Hotel(
    id: 'h1',
    imageUrl: 'assets/images/hotel1.jpg',
    name: 'Hotel 1',
    address: '404 Great St',
    description: 'Hotel 1 description',
    hotelFacilities: ['Park', 'Breakfast'],
    price: '300',
    imageUrls: [
      'assets/images/hotel1.jpg',
      'assets/images/hotel0.jpg',
      'assets/images/hotel2.jpg',
    ],
  ),
  Hotel(
    id: 'h2',
    imageUrl: 'assets/images/hotel2.jpg',
    name: 'Hotel 2',
    address: '404 Great St',
    description: 'Hotel 2 description',
    hotelFacilities: ['Bar', 'Wifi'],
    price: '240',
    imageUrls: [
      'assets/images/hotel2.jpg',
      'assets/images/hotel1.jpg',
      'assets/images/hotel0.jpg',
    ],
  ),
];
