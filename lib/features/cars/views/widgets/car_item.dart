import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/car_controller.dart';
import '../../models/car.dart';

class CarItem extends StatelessWidget {
  final Car car;
  const CarItem({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(car.model),
      subtitle: Text(car.year.toString()),
      trailing: IconButton(
        onPressed: () {
          context.read<CarController>().deleteById(car.id);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
