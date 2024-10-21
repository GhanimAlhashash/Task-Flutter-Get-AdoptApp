import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/services/pets.dart';
import 'package:flutter/material.dart';

class PetsProvider extends ChangeNotifier {
  List<Pet> pets = [
    Pet(
        name: "Lucifurr",
        image: "https://i.ibb.co/P6VJ4pZ/smile-cat-1.png",
        age: 2,
        gender: "male")
  ];

  Future<void> getPets() async {
    pets = await DioClient().getPets();
    notifyListeners();
  }

  void createPet(Pet pet) async {
    Pet newPet = await DioClient().createPet(pet: pet);
    pets.insert(0, newPet);
    notifyListeners();
  }

  void updatePet(Pet pet) async {
    Pet newPet = await DioClient().updatePet(pet: pet);
    pets.insert(0, newPet);
    notifyListeners();
  }
}
