import 'package:equatable/equatable.dart';

import '../data/data.dart';

// Events

class CalculateEvent extends Equatable {
  const CalculateEvent();

  @override
  List<Object?> get props => [];
}

class CalculateRequestEvent extends CalculateEvent {
  final Data data;
  const CalculateRequestEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class CalculateBackToDataEvent extends CalculateEvent {}

// States

class CalculateState extends Equatable {
  const CalculateState();

  @override
  List<Object?> get props => [];
}

class CalculateVoidState extends CalculateState {}

class CalculateIncorrectState extends CalculateState {}

class CalculateInProgressState extends CalculateState {}

class CalculateResponseState extends CalculateState {}
