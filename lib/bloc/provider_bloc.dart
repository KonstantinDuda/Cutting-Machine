import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/data.dart';

// Events

class ProviderEvent extends Equatable {
  ProviderEvent();

  @override
  List<Object?> get props => [];
}

class InstrumentEvent extends ProviderEvent {}

class LoadingEvent extends ProviderEvent {
  final Data data;
  LoadingEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class ResultEvent extends ProviderEvent {}

// States

class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object?> get props => [];
}

class InstrumentState extends ProviderState {}

class LoadingState extends ProviderState {
  final Data data;
  LoadingState(this.data);

  @override
  List<Object?> get props => [data];
}

class ResultState extends ProviderState {}

// Bloc

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(InstrumentState()) {
    on<InstrumentEvent>((event, emit) => emit(InstrumentState()));
    on<LoadingEvent>((event, emit) => emit(LoadingState(event.data)));
    on<ResultEvent>((event, emit) => emit(ResultState()));
  }
}
