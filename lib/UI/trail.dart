// counter_event.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



///CounterEvent: A base class for all counter-related events.
// IncrementEvent and DecrementEvent: Specific events for increasing and decreasing the counter.
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

///CounterState: A base class for all counter-related states.
// CounterValueState: A concrete state holding the current value of the counter
// counter_state.dart
abstract class CounterState {}

class CounterValueState extends CounterState {
  final int counterValue;
  CounterValueState(this.counterValue);
}
// counter_bloc.dart

//CounterBloc: Extends Bloc and takes CounterEvent and CounterState as types.
// super(CounterValueState(0)): Sets the initial state to CounterValueState with a value of 0.
// on<IncrementEvent>: When an IncrementEvent is triggered, the counter is incremented, and a new state is emitted.
// on<DecrementEvent>: When a DecrementEvent is triggered, the counter is decremented, and a new state is emitted.

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterValueState(0)) {
    // Event to state mapping
    on<IncrementEvent>((event, emit) {
      final currentState = state as CounterValueState;
      emit(CounterValueState(currentState.counterValue + 1));
    });

    on<DecrementEvent>((event, emit) {
      final currentState = state as CounterValueState;
      emit(CounterValueState(currentState.counterValue - 1));
    });
  }
}



///Explanation of the UI Code:
//
// BlocProvider:
//
// Provides the CounterBloc to the widget tree.
// Ensures that the Bloc is accessible anywhere inside the widget tree.
// BlocBuilder:
//
// Rebuilds the UI in response to state changes.
// Extracts the counterValue from the state and displays it.
// FloatingActionButton:
//
// Triggers the IncrementEvent and DecrementEvent when pressed.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Counter with Bloc')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            final counterValue =
                (state as CounterValueState).counterValue; // Access the counter value.
            return Text(
              'Counter: $counterValue',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.add(IncrementEvent());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              counterBloc.add(DecrementEvent());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
