import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_adoption_app/providers/pet_provider.dart';

import '../screens/details_page.dart';

class PetSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    petProvider.filterPetsByName(query);

    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        final filteredPets = petProvider.filteredPets;

        return ListView.builder(
          itemCount: filteredPets.length,
          itemBuilder: (context, index) {
            final pet = filteredPets[index];
            return ListTile(
              title: Text(pet.name),
              subtitle: Text('Age: ${pet.age}'),
              trailing: pet.adopted
                  ? Text('Already Adopted', style: TextStyle(color: Colors.grey))
                  : null,
              onTap: () {
                if (!pet.adopted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(pet: pet),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
