import 'package:flutter/material.dart';
import 'package:food_app/dummy_data.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/meal_detail_screen.dart';
import 'package:food_app/screens/meals_screen.dart';
import 'package:food_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _toggleFavorite(String id) {
    final existingId = _favorites.indexWhere((meal) => meal.id == id);

    if (existingId >= 0) {
      setState(() {
        _favorites.removeAt(existingId);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favorites.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Food',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.red,
          // canvasColor: Color.fromARGB(255, 197, 201, 203),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleMedium: const TextStyle(
                fontSize: 22,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      // home: const TabsScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favorites),
        MealsScreen.routeName: (context) => MealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      }),
    );
  }
}
