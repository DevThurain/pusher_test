import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>((event, emit) {
      if (event is IncreamentEvent) {
        emit(state + 1);
      }
    });
  }

  void increment() {
    addError("tesing Error", StackTrace.current);
    emit(state + 1);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    //print('$error , $stackTrace');
    super.onError(error, stackTrace);
  }

  @override
  void onChange(Change<int> change) {
     super.onChange(change);
    print(change);
  }
}
