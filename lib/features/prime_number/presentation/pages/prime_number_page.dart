import 'package:clock_app/di_config.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimeNumberPage extends StatelessWidget {
  const PrimeNumberPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: BlocBuilder<PrimeNumberCubit, PrimeNumberCubitState>(
        bloc: getIt.get<PrimeNumberCubit>(),
        builder: (context, state) {
          if (state is PrimeNumberPopulatedState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Congrats!',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'You obtained a prime number, it was: ${state.number}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    state.timeElapsedSinceLastPrimeNumber != null
                        ? 'Time since last prime number: ${state.timeElapsedSinceLastPrimeNumber}'
                        : 'This is your first prime number!',
                    style: TextStyle(color: Colors.white60, fontSize: 18),
                  ),
                  Spacer(),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
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
