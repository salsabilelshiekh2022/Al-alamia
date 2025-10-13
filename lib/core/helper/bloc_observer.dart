import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('✅✅✅ onCreate ===> ${bloc.runtimeType} \n');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      '-------------------------------------------------------  Start  --------------------------------------------------------',
    );
    log(
      '🔄🔄🔄 onChange ===> ${bloc.runtimeType} ====> \n ${_formatOnChangeResponse(change)}',
    );
    log(
      '-------------------------------------------------------  End  --------------------------------------------------------',
    );
  }

  _formatOnChangeResponse(Change change) {
    return '---------- Current state ===>\n ${_formatObjectString(change.currentState.toString())} \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t <<< ========== ${change.runtimeType} ========== >>> \n ---------- Next state ===>\n ${_formatObjectString(change.nextState.toString())}';
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('❌❌❌ onError ===> ${bloc.runtimeType},\n $error \n');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('🚪🚪🚪 onClose ===> ${bloc.runtimeType} \n');
  }

  String _formatObjectString(String input) {
    final output = StringBuffer();
    int indentLevel = 0;
    bool inQuotes = false;

    for (int i = 0; i < input.length; i++) {
      final char = input[i];

      if (char == '"' && (i == 0 || input[i - 1] != '\\')) {
        inQuotes = !inQuotes;
      }

      if (!inQuotes) {
        if (char == '{' || char == '[') {
          output.write(char);
          output.write('\n');
          indentLevel++;
          output.write('  ' * indentLevel);
        } else if (char == '}' || char == ']') {
          output.write('\n');
          indentLevel--;
          output.write('  ' * indentLevel);
          output.write(char);
        } else if (char == ',') {
          output.write(char);
          output.write('\n');
          output.write('  ' * indentLevel);
        } else if (char == ':') {
          output.write(' : ');
        } else {
          output.write(char);
        }
      } else {
        output.write(char);
      }
    }

    return output.toString();
  }
}
