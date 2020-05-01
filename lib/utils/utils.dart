import 'package:fluttertoast/fluttertoast.dart';

// function for showing custom toast message
void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
