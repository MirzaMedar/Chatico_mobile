import 'package:flutter/foundation.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

class SocketProvider extends ChangeNotifier {
  SocketIO _socketIO;

  setSocket(SocketIO socket) {
    _socketIO = socket;
    notifyListeners();
  }

  getSocket() => _socketIO;
}
