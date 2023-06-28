import 'package:doan1/EventBus/Events/Authenevent.dart';
import 'package:doan1/EventBus/Events/NewBookingEvent.dart';
import 'package:doan1/EventBus/Events/TestEvent.dart';
import 'package:doan1/data/Preferences.dart';
import 'package:doan1/data/model/datebooking.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../EventBus/Events/ApprovedEvent.dart';
import '../Notifications/notification_service.dart';

class SocketRepo{
  final SharedPreferences _sharedPreferences;
  final EventBus _eventBus;
  final String _baseUrl;
  IO.Socket? _socket;
  SocketRepo(this._sharedPreferences, this._baseUrl, this._eventBus){
    _eventBus.on<EBAuthenEvent>().listen((event) async{
      if(event.authenticateStatus){
        if(_socket == null) {
          _socket = IO.io(_baseUrl,
              IO.OptionBuilder()
                  .setTransports(['websocket']) // for Flutter or Dart VM
                  .disableAutoConnect() // disable auto-connection
                  .enableForceNewConnection()
                  .setExtraHeaders({
                'Authorization':"Bearer "+ (await _sharedPreferences.getString(Preferences.token)??''),
              }) // optional
                  .build()
          );
          _socket!.connect();
          _socket!.on("message", (data) =>
          {
            _eventBus.fire(EBTestEvent(data))
          });

          _socket!.on("CreateBooking", (data) async
          {
            await LocalNotificationService.display("New booking!", "You have a new booking request", null);
            try{
              final booking = DateBooking.fromJson(data);
              _eventBus.fire(NewBookingEvent(booking));
            }
            catch(e){
              print(e);
            }

          }
          );

          _socket!.on("RejectBookingOwner", (data)
          {
            print(data);
          });

          _socket!.on("RejectBookingUser", (data)
          {
            print(data);
          });

          _socket!.on("ApproveBooking", (data)
          async
          {
            await LocalNotificationService.display("Booking approved!", "Your booking request has been approved", null);
            try{
              final booking = DateBooking.fromJson(data);
              _eventBus.fire(ApprovedEvent(booking));
            }
            catch(e){
              print(e);
            }
          });
        }
      }else{
        if(_socket!=null){
          _socket!.disconnect();
          _socket!.destroy();
          _socket = null;
        }
      }
    });
  }
}