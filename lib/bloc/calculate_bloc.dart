import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_calculator/event_state/calculate_es.dart';

class CalculateBloc extends Bloc<CalculateEvent, CalculateState> {
  CalculateBloc() : super(CalculateVoidState()) {
    on<CalculateRequestEvent>(_calculateInProgress);
    on<CalculateBackToDataEvent>(_calculateBackToData);
  }

  Future<void> _calculateInProgress(
      CalculateRequestEvent event, Emitter<CalculateState> emit) async {
    print('Calculate In Progres. This event == $event');

    final isolate = await Isolate.run(() async {
      return _myIsolate();
      //var res = await _myIsolate();
      //return res;
    });
    //print("Seems like correct program... $isolate");
    print("I use _myIsolate func");

    emit(CalculateResponseState());

    //_calculateIncorrectData(emit);
  }

  static _myIsolate() {
    List<String> list = [];
    print('My Isolate');
    for (var i = 0; i < 1000; i++) {
      for (var j = 0; j < 1000; j++) {
        list.add('i:$i  j:$j');
      }
    }
    return list;
  }

  _calculateBackToData(
      CalculateBackToDataEvent event, Emitter<CalculateState> emit) {}

  _calculateIncorrectData(Emitter<CalculateState> emit) {
    emit(CalculateIncorrectState());
  }
}
