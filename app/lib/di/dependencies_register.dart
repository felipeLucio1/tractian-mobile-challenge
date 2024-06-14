import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getitInstance = GetIt.I;

@InjectableInit()
void setupDependencies() => $initGetIt(getitInstance);
