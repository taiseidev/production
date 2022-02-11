import 'dart:async';
import 'dart:io';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Alarm {
  Timer? _timer;

  void alertStart() {
    if (Platform.isIOS) {
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (Timer timer) {
          {
            FlutterRingtonePlayer.play(
              android: AndroidSounds.notification,
              ios: const IosSound(1335),
              volume: 0.1,
            );
          }
        },
      );
    } else if (Platform.isAndroid) {
      FlutterRingtonePlayer.playAlarm();
    }
  }

  void alertStop() {
    if (Platform.isAndroid) {
      FlutterRingtonePlayer.stop();
    } else if (Platform.isIOS) {
      if (_timer != null && _timer!.isActive) _timer!.cancel();
    }
  }
}
