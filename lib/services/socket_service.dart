import 'package:fannelance/core/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;
  List<dynamic> availableWorkers = [];

  Future<void> connect() async {
    await dotenv.load(fileName: '.env');
    final String? serverURL = dotenv.env['serverURL'];

    socket = IO.io(serverURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('Connected to WebSocket Server');
    });

    socket!.onDisconnect((_) {
      print('Disconnected from WebSocket Server');
    });
  }

  void listenToAvailableWorkers(
      String jobTitle, Function(List<dynamic>) onDataReceived) async {
    String? token = await kSecureStorage.read(key: 'token');
    socket!.emit('available-workers', [token, jobTitle]);
    socket!.on('send-workers', (data) {
      availableWorkers = data;
      onDataReceived(data);
    });
  }

  Future<void> listenToAcceptedRequest(
      Function(dynamic) onRequestAccepted) async {
    String? token = await kSecureStorage.read(key: 'token');
    String userId = JwtDecoder.decode(token!)['_id'];

    socket!.on('request-$userId', (requestId) {
      onRequestAccepted(requestId);
    });
  }

  void listenToChosenWorker(Function(dynamic) onWorkerChosen) {
    socket!.on('chosen-worker', (workerId) {
      onWorkerChosen(workerId);
    });
  }

  Future<void> sendRequest(String workerId) async {
    String? token = await kSecureStorage.read(key: 'token');
    print('Sending request to worker $workerId');
    socket!.emit('send-request', [token, workerId]);
  }

  Future<void> sendTimeout(String workerId) async {
    socket!.emit('timeout', workerId);
  }

  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
    }
  }
}
