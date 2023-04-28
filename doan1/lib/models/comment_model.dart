class Comment{
  String customerId;
  int ratingStar;
  String comment;
  String time;

  Comment({
    required this.customerId,
    required this.ratingStar,
    required this.comment,
    required this.time
  });
}

//Note: This is a dummy data for testing purpose
List<Comment> comments = [
  Comment(
    customerId: '1',
    ratingStar: 5,
    comment: 'Tour 0 comment 1',
    time: '2021-01-01 00:00:00',
  ),
  Comment(
    customerId: '2',
    ratingStar: 4,
    comment: 'Tour 0 comment 2',
    time: '2021-01-01 00:00:00',
  ),
  Comment(
    customerId: '3',
    ratingStar: 3,
    comment: 'Tour 0 comment 3',
    time: '2021-01-01 00:00:00',
  ),
  Comment(
    customerId: '4',
    ratingStar: 2,
    comment: 'Tour 0 comment 4',
    time: '2021-01-01 00:00:00',
  ),
];