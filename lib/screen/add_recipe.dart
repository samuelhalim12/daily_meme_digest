import 'package:flutter/material.dart';
import 'package:daily_meme_digest/class/recipe.dart';

class AddRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescController = TextEditingController();
  final TextEditingController _recipePhotoController = TextEditingController();
  // final TextEditingController _categoryId = TextEditingController();
  int _charLeft = 200;
  String _recipeCategory = "Traditional";

  @override
  void initState() {
    super.initState();
    _recipeNameController.text = "your recipe here...";
    _recipeDescController.text = "Recipe of ...";
    _recipePhotoController.text =
        "https://cookpad.com/id/recipe/images/Recipe_2014_12_12_07_07_40_613_4f10254c00115e6e04d1";
    _charLeft = 200 - _recipeDescController.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _recipeNameController,
            onChanged: (value) {
              print(_recipeNameController.text);
              print(value);
            },
          ),
          TextField(
            controller: _recipeDescController,
            onChanged: (value) {
              setState(() {
                _charLeft = 200 - value.length;
              });
            },
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
          ),
          Text("Characters left: $_charLeft / 200"),
          TextField(
            controller: _recipePhotoController,
            onSubmitted: (value) {
              setState(() {});
            },
          ),
          Image.network(_recipePhotoController.text),
          DropdownButton(
              value: _recipeCategory,
              items: const [
                DropdownMenuItem(
                  child: Text("Traditional"),
                  value: "Traditional",
                ),
                DropdownMenuItem(
                  child: Text("Japanese"),
                  value: "Japanese",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _recipeCategory = value.toString();
                });
              }),
          ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor:
                      MaterialStateProperty.resolveWith(getButtonColor)),
              onPressed: () {
                recipes.add(Recipe(
                    id: recipes.length + 1,
                    name: _recipeNameController.text,
                    photo: _recipePhotoController.text,
                    desc: _recipeDescController.text,
                    category: _recipeCategory.toString()));
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Add Recipe'),
                          content: const Text('Recipe successfully added'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              },
              icon: const Icon(Icons.add),
              label: const Text("Submit")),
        ],
      ),
    );
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) return Colors.red;
    return Colors.green;
  }
}
