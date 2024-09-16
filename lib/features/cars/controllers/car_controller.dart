import 'package:flutter/material.dart';

import '../models/car.dart';
import '../services/car_service.dart';

class CarController with ChangeNotifier {
  final CarService _carService;
  List<Car> _cars = [];

  Future<List<Car>> get cars async {
    _cars = await _carService.get();
    return [..._cars];
  }

  CarController({
    required CarService carService,
  }) : _carService = carService;

  Future<void> addCar({
    required String model,
    required int year,
  }) async {
    // add car
    await _carService.insert(model: model, year: year);
    notifyListeners();
  }

  Future<void> deleteById(int carId) async {
    // add car
    await _carService.delete(carId);
    notifyListeners();
  }
}
