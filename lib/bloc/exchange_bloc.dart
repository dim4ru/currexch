import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {
    on<ExchangeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
