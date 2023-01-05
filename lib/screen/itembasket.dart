import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBasket extends StatelessWidget{
  final int id;
  final int count;
  ItemBasket(this.id, this.count);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text("Basket Item"),
      ),
      body: Center(
        child: Text("Item ID $id count $count"),
      )
    );
  }
}
