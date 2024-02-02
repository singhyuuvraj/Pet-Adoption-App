import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_adoption_app/models/pet.dart';
import 'package:pet_adoption_app/providers/pet_provider.dart';
import 'package:pet_adoption_app/screens/details_page.dart';
import '../utils/pet_search_delegate.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adoption'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PetSearchDelegate());
            },
          ),
        ],
      ),
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          final pets = petProvider.filteredPets;

          return GridView.builder(
            padding: EdgeInsets.all(16),
            itemCount: pets.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final pet = pets[index];

              return GestureDetector(
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
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: pet.adopted ? Colors.grey.withOpacity(0.3) : Colors.white,
                    border: Border.all(color:Color(0xffF2D1C7), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color:Color(0xffF2D1C7).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text('Age: ${pet.age}', style: TextStyle(color: Colors.black)),
                      if (pet.adopted)
                        Text(
                          'Already Adopted',
                          style: TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(),
            ),
          );
        },
        child: Icon(Icons.history),
      ),
    );
  }
}
