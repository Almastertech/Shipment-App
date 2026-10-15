import 'dart:async';

class Debouncer {
  Debouncer({required int milliseconds})
      : _duration = Duration(milliseconds: milliseconds);

  final Duration _duration;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(_duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
