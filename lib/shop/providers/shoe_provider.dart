import 'package:eighty_two/shop/models/shoe.dart';
import 'package:eighty_two/shop/repositories/repositories.dart';
import 'package:flutter/material.dart';

class ShoeProvider extends ChangeNotifier {
  ShoeProvider({
    List<Shoe>? shoes,
    required this.shoeRepository,
  }) : shoes = shoes ?? [];

  List<Shoe> shoes;
  ShoeRepository shoeRepository;

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  Future<void> getShoes() async {
    isLoading = true;
    hasError = false;
    errorMessage = null;
    notifyListeners();

    try {
      shoes = await shoeRepository.getShoes();
    } catch (exception) {
      hasError = true;
      errorMessage = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
