import 'package:app/di/dependencies_register.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getitInstance = GetIt.I;

@InjectableInit()
void setupDependencies() => getitInstance.init();
