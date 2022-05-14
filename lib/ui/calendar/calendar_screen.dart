import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_test/ui/calendar/bloc/counter_bloc.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = 'calendar_screen';
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: (() => context.read<CounterBloc>().increment()),
          );
        }),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              Container(
                child: BlocBuilder<CounterBloc, int>(
                  // buildWhen: (previous, current) {
                  //   print('previous => $previous && current => $current');
                  //   return current % 2 == 0;
                  // },
                  builder: (context, state) {
                    print('i am building ...');
                    return Text(state.toString());
                  },
                ),
              ),
              Builder(builder: (context) {
                return Container(
                  child: Text(context.watch<CounterBloc>().state.toString()),
                );
              })
            ],
          )),
        ),
      ),
    );
  }
}
