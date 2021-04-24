import 'dart:async';

main() {
  Timer(Duration(seconds: 3), _onTimeout);
  Timer(Duration(seconds: 1), _onTimeout2);

  // scheduleMicrotask(_now);
}

void _onTimeout() {
  print('_onTimeout${DateTime.now()}');
}


// void _now() {
//   print('${DateTime.now()}');
// }

void _onTimeout2() {
  print('_onTimeout2${DateTime.now()}');
}
