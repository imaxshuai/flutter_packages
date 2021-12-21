import 'package:logger/logger.dart';

class IPrefixPrinter extends LogPrinter {
  final LogPrinter _realPrinter;
  late Map<Level, String> _prefixMap;

  IPrefixPrinter(this._realPrinter,
      {debug, verbose, wtf, info, warning, error, nothing}) : super() {
    _prefixMap = {
      Level.debug: debug ?? '  DEBUG ',
      Level.verbose: verbose ?? 'VERBOSE ',
      Level.wtf: wtf ?? '    WTF ',
      Level.info: info ?? '   INFO ',
      Level.warning: warning ?? 'WARNING ',
      Level.error: error ?? '  ERROR ',
      Level.nothing: nothing ?? 'NOTHING',
    };
  }

  @override
  List<String> log(LogEvent event) {
    return _realPrinter.log(event).map((s) => '${_prefixMap[event.level]}$s').toList();
  }
}

Logger logger = Logger(
  printer: IPrefixPrinter(PrettyPrinter(
    stackTraceBeginIndex: 0,
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: false,
    printEmojis: true,
    printTime: false,
    excludeBox: const {},
    noBoxingByDefault: false,
  )),
);