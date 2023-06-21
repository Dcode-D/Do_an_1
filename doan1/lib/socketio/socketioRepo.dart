import 'package:doan1/EventBus/Events/Authenevent.dart';
import 'package:doan1/EventBus/Events/TestEvent.dart';
import 'package:doan1/data/Preferences.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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