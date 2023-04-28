class TourGroup {
  String id;
  String name;
  int slot;
  DateTime startDate;
  DateTime endDate;
  String tourLeaderId;
  String tourLeaderName;
  String tourDeputyId;
  String tourDeputyName;
  String tourId;
  String tourName;
  String customerList;

  TourGroup({
    required this.id,
    required this.name,
    required this.slot,
    required this.startDate,
    required this.endDate,
    required this.tourLeaderId,
    required this.tourLeaderName,
    required this.tourDeputyId,
    required this.tourDeputyName,
    required this.tourId,
    required this.tourName,
    required this.customerList
  });

  List<String> get customerListSplited => customerList.split(',');
}