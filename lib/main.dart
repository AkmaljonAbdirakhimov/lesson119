import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson119/features/cars/services/car_service.dart';
import 'package:provider/provider.dart';

import 'features/cars/controllers/car_controller.dart';
import 'features/cars/views/cars_screen.dart';
import 'features/contacts/controllers/contact_controller.dart';
import 'features/contacts/models/contact.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  final hiveBox = await Hive.openBox("contacts");

  final carService = CarService();
  await carService.init();

  runApp(MainApp(hiveBox: hiveBox, carService: carService));
}

class MainApp extends StatelessWidget {
  final Box hiveBox;
  final CarService carService;
  const MainApp({
    super.key,
    required this.hiveBox,
    required this.carService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactController(hiveBox: hiveBox),
        ),
        ChangeNotifierProvider(
          create: (context) => CarController(carService: carService),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CarsScreen(),
      ),
    );
  }
}
