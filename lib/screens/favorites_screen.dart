import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favorites;

  FavoritesScreen(this.favorites);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          "You don't have favorites yet.",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: ((context, index) {
            return MealItem(
                id: favorites[index].id,
                title: favorites[index].title,
                affordability: favorites[index].affordability,
                complexity: favorites[index].complexity,
                duration: favorites[index].duration,
                imageUrl: favorites[index].imageUrl);
          }));
    }
  }
}
