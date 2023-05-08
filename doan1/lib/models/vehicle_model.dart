
class Vehicle{
  String id;
  String imageUrl;
  String name;
  String address;
  String description;
  String price;
  String type;

  Vehicle({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.description,
    required this.price,
    required this.type
  });
}

List<Vehicle> vehicles = [
  Vehicle(
      id: 'v0',
      imageUrl: 'assets/images/car0.jpg',
      name: '2021 Mercedes-AMG GLE53',
      address: 'Thành phố Hồ Chí Minh',
      description: 'Car 0',
      price: '120',
      type: 'car'
  ),
  Vehicle(
      id: 'v1',
      imageUrl: 'assets/images/car1.jpg',
      name: 'The 2019 Volvo XC40',
      address: 'Thành phố Đà Lạt',
      description: 'Car 1',
      price: '100',
      type: 'car'
  ),Vehicle(
      id: 'v2',
      imageUrl: 'assets/images/bike2.jpg',
      name: 'BMW S1000RR 2022',
      address: 'Vĩnh Long',
      description: 'Bike 2',
      price: '133',
      type: 'bike'
  ),
];