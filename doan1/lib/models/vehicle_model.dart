
class Vehicle{
  String id;
  String imageUrl;
  String name;
  String address;
  String description;
  String price;
  String owner;
  String type;

  Vehicle({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.description,
    required this.price,
    required this.owner,
    required this.type
  });
}

List<Vehicle> vehicles = [
  Vehicle(
      id: 'v0',
      imageUrl: 'assets/images/car0.jpg',
      name: '2021 Mercedes-AMG GLE53',
      address: 'Thành phố Hồ Chí Minh',
      description: 'Xe có 7 chỗ có thể chứa 4 vali, có số tự động',
      price: '120',
      owner: 'Nhà xe Futa',
      type: 'car'
  ),
  Vehicle(
      id: 'v1',
      imageUrl: 'assets/images/car1.jpg',
      name: 'The 2019 Volvo XC40',
      address: 'Thành phố Đà Lạt',
      description: 'Xe có 4 chỗ có thể chứa 4 vali, có số tự động',
      price: '100',
      owner: 'Khách sạn Hoà Bình',
      type: 'car'
  ),Vehicle(
      id: 'v2',
      imageUrl: 'assets/images/bike2.jpg',
      name: 'BMW S1000RR 2022',
      address: 'Vĩnh Long',
      description: 'Xe có 2 chỗ và có hỗ trợ nón bảo hiểm',
      price: '133',
      owner: 'Nhà xe Thành Bưởi',
      type: 'bike'
  ),
];