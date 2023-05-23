class Destination {
  String id;
  List<String> images;
  String name;
  String description;
  String province;

  Destination({
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.province,
  });
}

//Note: This is a dummy data for testing purpose
List<Destination> destinationList = [
  Destination(
      id: "Des1",
      images:
      [
        "assets/images/destination1.jpg",
        "assets/images/destination2.jpg",
        "assets/images/destination3.jpg",],
      name: "Thành phố Đà Lạt",
      description: "Đà Lạt is a city in Vietnam. It is the capital of Lâm Đồng Province.",
      province: "Lâm Đồng"
  ),
  Destination(
      id: "Des2",
      images:
      [
        "assets/images/destination2.jpg",
        "assets/images/destination1.jpg",
        "assets/images/destination3.jpg",],
      name: "Thành phố Hà Nội",
      description: "Hà Nội is the capital and most populous city of Vietnam.",
      province: "Hà Nội"
  ),
  Destination(
      id: "Des3",
      images: [
        "assets/images/destination3.jpg",
        "assets/images/destination2.jpg",
        "assets/images/destination4.jpg",],
      name: "Toà nhà Landmark 81",
      description: "Landmark 81 is a 81-story skyscraper in Ho Chi Minh City, Vietnam.",
      province: "Hồ Chí Minh"
  ),
  Destination(
      id: "Des4",
      images: [
        "assets/images/destination4.jpg",
        "assets/images/destination1.jpg",
        "assets/images/destination3.jpg",],
      name: "Hội An",
      description: "Hội An is a city in Vietnam. It is the capital of Quảng Nam Province.",
      province: "Quảng Nam"
  )
];