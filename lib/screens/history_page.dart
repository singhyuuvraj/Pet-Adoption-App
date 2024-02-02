import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_adoption_app/models/pet.dart';
import 'package:pet_adoption_app/providers/pet_provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption History'),
      ),
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          final adoptedPets = petProvider.adoptedPets;

          if (adoptedPets.isEmpty) {
            return Center(
              child: Text('No pets adopted yet.'),
            );
          }

          adoptedPets.sort((a, b) => a.adoptionDate!.compareTo(b.adoptionDate!));

          return ListView.builder(
            itemCount: adoptedPets.length,
            itemBuilder: (context, index) {
              final pet = adoptedPets[index];
              return ListTile(
                title: Text(pet.name),
                subtitle: Text('Adoption Date: ${_formatDate(pet.adoptionDate!)}'),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
