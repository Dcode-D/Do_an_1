class Destination {
  String id;
  String img;
  String name;
  String description;
  String province;

  Destination({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.province,
  });
}

//Note: This is a dummy data for testing purpose
List<Destination> destinationList = [
  Destination(
      id: "Des1",
      img: "assets/images/destination1.jpg",
      name: "Thành phố Đà Lạt",
      description: "Đà Lạt is a city in Vietnam. It is the capital of Lâm Đồng Province.",
      province: "Lâm Đồng"
  ),
  Destination(
      id: "Des2",
      img: "assets/images/destination2.jpg",
      name: "Thành phố Hà Nội",
      description: "Hà Nội is the capital and most populous city of Vietnam.",
      province: "Hà Nội"
  ),
  Destination(
      id: "Des3",
      img: "assets/images/destination3.jpg",
      name: "Toà nhà Landmark 81",
      description: "Landmark 81 is a 81-story skyscraper in Ho Chi Minh City, Vietnam.",
      province: "Hồ Chí Minh"
  ),
  Destination(
      id: "Des4",
      img: "assets/images/destination4.jpg",
      name: "Hội An",
      description: "Hội An is a city in Vietnam. It is the capital of Quảng Nam Province.",
      province: "Quảng Nam"
  )
];