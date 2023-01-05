import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/screen/itembasket.dart';
import 'package:daily_meme_digest/class/recipe.dart';

class Basket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BasketState();
  }
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Text("Your basket "),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: widRecipes(context),
        ),
        const Divider(
          height: 100,
        )
      ])),

      /*body: Column(
          children: [
            const Text("This is Basket"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(1, 20)));
                },
                child: const Text("Item 1")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(2, 15)));
                },
                child: const Text("Item 2"))
          ],
        )*/
    );
  }

  List<Widget> widRecipes(BuildContext context) {
    List<Widget> temp = [];
    int i = 0;
    while (i < recipes.length) {
      var recipe = recipes[i];
      Widget w = Card(
          margin: const EdgeInsets.all(16),
          elevation: 8,
          child: Column(
            children: [
              Text(recipe.name + ' (' + recipe.category + ')'),
              Image.network(recipe.photo),
              Text(recipe.desc),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getButtonColor)),
                  onPressed: () {
                    // print(recipes[1].toString());
                    recipes.removeAt(recipe.id-1);
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Delete Recipe'),
                              content:
                                  const Text('Recipe successfully deleted'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete")),
            ],
          ));
      temp.add(w);
      i++;
    }
    return temp;
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) return Colors.red;
    return Colors.green;
  }
}
