import 'dart:async';
import 'dart:io';

void main() {
  Timer.periodic(const Duration(seconds: 7), (timer) async {
    // AppleScript command to type "hello"
    const script = 'tell application "System Events" to keystroke "hello"';
    await Process.run('osascript', ['-e', script]);
  });
}
