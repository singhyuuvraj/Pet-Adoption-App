import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_adoption_app/providers/pet_provider.dart';
import 'package:pet_adoption_app/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PetProvider()),
      ],
      child: MaterialApp(
        title: 'Pet Adoption App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xffF2D1C7),
            secondary: Color(0xffF2D1C7),
          ),
          textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
        ),
        home: HomePage(),
      ),
    );
  }
}
