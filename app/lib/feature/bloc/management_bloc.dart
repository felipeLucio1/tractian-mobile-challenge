import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  ManagementBloc() : super(LoadingScreenInitialState()) {
    on<ManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
