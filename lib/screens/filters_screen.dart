import 'package:flutter/material.dart';
import 'package:food_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';

  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  Widget _buildSwitch(
    String title,
    String subtitle,
    bool value,
    Function changeValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: (value) => changeValue(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final savedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(savedFilters);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your selection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitch(
                    'Gluten-free', 'Only show Gluten-free foods', _glutenFree,
                    (bool val) {
                  setState(() {
                    _glutenFree = val;
                  });
                }),
                _buildSwitch('Lactose-free', 'Only show Lactose-free foods',
                    _lactoseFree, (bool val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                }),
                _buildSwitch('Vegan', 'Only show Vegan foods', _vegan,
                    (bool val) {
                  setState(() {
                    _vegan = val;
                  });
                }),
                _buildSwitch(
                    'Vegetarian', 'Only show Vegetarian foods', _vegetarian,
                    (bool val) {
                  setState(() {
                    _vegetarian = val;
                  });
                })
              ],
            ))
          ],
        ));
  }
}
