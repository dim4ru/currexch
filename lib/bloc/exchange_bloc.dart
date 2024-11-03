import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {
    on<UserRequestExchange>((event, emit) async {
      emit(ExchangeLoading());

      await Future.delayed(const Duration(seconds: 1));
      emit(ExchangeApiSuccessful());
    });
  }
}
