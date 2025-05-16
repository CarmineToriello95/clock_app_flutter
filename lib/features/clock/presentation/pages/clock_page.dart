import 'package:clock_app/di_config.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late final ClockCubit _clockCubit;

  @override
  void initState() {
    super.initState();
    _clockCubit = getIt.get<ClockCubit>()..startClock();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: BlocBuilder<ClockCubit, ClockCubitState>(
        bloc: _clockCubit,
        builder: (_, state) {
          if (state is ClockPopulatedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.time,
                    style: TextStyle(color: Colors.white, fontSize: 96),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.day,
                        style: TextStyle(color: Colors.white, fontSize: 48),
                      ),
                      Text(
                        'CW ${state.calendarWeek}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ),
  );
}
