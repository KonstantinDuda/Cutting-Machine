import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:work_calculator/bloc/calculate_bloc.dart';
import 'package:work_calculator/bloc/provider_bloc.dart';
import 'package:work_calculator/event_state/calculate_es.dart';

class LoadingView extends StatefulWidget {
  //final Data data;
  const LoadingView(/*this.data,*/ {super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    //context.read<CalculateBloc>().add(CalculateRequestEvent(widget.data));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Calculating'),
        ),
        body: BlocBuilder<CalculateBloc, CalculateState>(
          builder: (context, state) {
            /*context
                .read<CalculateBloc>()
                .add(CalculateRequestEvent(widget.data));*/
            if (state is CalculateResponseState) {
              context.read<ProviderBloc>().add(ResultEvent());
            }
            return const Center(
              child: SpinKitPianoWave(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          },
        ),
        floatingActionButton: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: () {
              context.read<ProviderBloc>().add(InstrumentEvent());
            },
            child: const Text(
              'Go back',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
