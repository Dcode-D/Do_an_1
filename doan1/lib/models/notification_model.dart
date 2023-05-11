class NotificationInfo{
  String type;
  String title;
  String content;
  String time;
  NotificationInfo({
    required this.type,
    required this.title,
    required this.content,
    required this.time});
}

List<NotificationInfo> notifications = [
  NotificationInfo(
      type: 'alert',
      title: 'Account Update',
      content: 'Your account has been updated',
      time: '2 hours ago'),
  NotificationInfo(
      type: 'info',
      title: 'Hotel booked successfully',
      content: 'Hotel booked successfully',
      time: '2 hours ago'),
  NotificationInfo(
      type: 'info',
      title: 'Vehicle booked successfully',
      content: 'Vehicle booked successfully',
      time: '2 hours ago'),
  NotificationInfo(
      type: 'info',
      title: 'Tour booked successfully',
      content: 'Tour booked successfully',
      time: '2 hours ago'),
];