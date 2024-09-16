import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/car_controller.dart';
import 'widgets/car_item.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars"),
        actions: [
          IconButton(
            onPressed: () {
              const String model = "Lexus";
              const int year = 2024;

              context.read<CarController>().addCar(
                    model: model,
                    year: year,
                  );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<CarController>(builder: (context, carsController, child) {
        return FutureBuilder(
          future: carsController.cars,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("NO CARS"),
              );
            }

            final cars = snapshot.data!;

            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return CarItem(
                  car: car,
                );
              },
            );
          },
        );
      }),
    );
  }
}
