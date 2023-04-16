import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    printEmojis: true,
    colors: true,
  ),
);
