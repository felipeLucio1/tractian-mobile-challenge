import 'package:app/di/dependencies_register.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart' as log;

final getitInstance = GetIt.I;

@InjectableInit()
void setupDependencies() => getitInstance.init();

@injectable
class LoggerWrapper {
  final logger = log.Logger('start log');
}
