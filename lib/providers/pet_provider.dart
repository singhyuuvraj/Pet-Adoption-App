import 'package:flutter/foundation.dart';
import 'package:pet_adoption_app/models/pet.dart';

class PetProvider extends ChangeNotifier {
  List<Pet> _pets = [];
  List<Pet> _adoptedPets = [];
  String _searchQuery = "";

  PetProvider() {

    _addPet(Pet(
      id: '1',
      name: 'Fluffy',
      age: '2 years',
      price: 100.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '2',
      name: 'Buddy',
      age: '3 years',
      price: 150.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '3',
      name: 'Whiskers',
      age: '1 year',
      price: 80.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));


    _addPet(Pet(
      id: '4',
      name: 'Tom',
      age: '3 year',
      price: 50.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '5',
      name: 'Pablo',
      age: '3 year',
      price: 100.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '6',
      name: 'Jackie',
      age: '5 year',
      price: 140.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '7',
      name: 'Marcelo',
      age: '2 year',
      price: 100.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '8',
      name: 'Dino',
      age: '1 year',
      price: 80.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '9',
      name: 'Georgy',
      age: '2.3 year',
      price: 50.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));

    _addPet(Pet(
      id: '8',
      name: 'Liril',
      age: '1.5 year',
      price: 110.0,
      imageUrl: 'https://shorturl.at/lsuKY',
    ));
  }

  List<Pet> get pets => _pets;
  List<Pet> get adoptedPets => _adoptedPets;

  List<Pet> get filteredPets {
    return _pets.where((pet) => pet.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  void _addPet(Pet pet) {
    _pets.add(pet);
  }

  void addPets(List<Pet> pets) {
    _pets = pets;
    notifyListeners();
  }

  void adoptPet(Pet pet) {
    pet.adopted = true;
    pet.adoptionDate = DateTime.now();
    _adoptedPets.add(pet);
    notifyListeners();
  }

  void filterPetsByName(String query) {
    _searchQuery = query;
    notifyListeners();
  }

}
