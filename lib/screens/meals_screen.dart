import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static String routeName = '/category-meals';

  final List<Meal> availableMeals;

  MealsScreen(this.availableMeals);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String title;
  late List<Meal> displayedMeals;
  bool _loadedData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      title = routeArgs['title'] as String;
      final String id = routeArgs['id'] as String;

      displayedMeals = widget.availableMeals
          .where(((meal) => meal.categories.contains(id)))
          .toList();
      _loadedData = true;
    }
  }

  void _removeMeal(String id) {
    displayedMeals.removeWhere((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
          itemCount: displayedMeals.length,
          itemBuilder: ((context, index) {
            return MealItem(
                id: displayedMeals[index].id,
                title: displayedMeals[index].title,
                affordability: displayedMeals[index].affordability,
                complexity: displayedMeals[index].complexity,
                duration: displayedMeals[index].duration,
                imageUrl: displayedMeals[index].imageUrl);
          })),
    );
  }
}
