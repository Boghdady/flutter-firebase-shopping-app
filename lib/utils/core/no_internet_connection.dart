import 'package:connectivity/connectivity.dart';
import '../../utils/core/exceptions.dart';

Future<void> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    throw NoInternetConnectionException();
  }
}
