import 'dart:convert';

import 'package:flutter/material.dart';
import '../class/cart.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class ViewCart extends StatefulWidget {
  const ViewCart({super.key});

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  final dbHelper = DatabaseHelper.instance;
  List? _rsCart;

  _bacaData() async {
    _rsCart = (await dbHelper.viewCart())!;
    setState(() {});
  }

  Widget _itemCart(index) {
    var item = _rsCart?[index];

    return item == null
        ? const Text('Tidak ada data')
        : Column(children: <Widget>[
            Text(item['title']),
            Row(
              children: [
                Text('jumlah=${item['jumlah']}'),
                ElevatedButton(
                    onPressed: () {
                      dbHelper
                          .tambahJumlah(_rsCart?[index]['movie_id'])
                          .then((value) => _bacaData());
                    },
                    child: const Text("+")),
              ],
            ),
            const Divider(),
          ]);
  }

  void _submit() async {
    _rsCart = await dbHelper.viewCart();
    String items = "";
    _rsCart?.forEach((item) {
      items = '$items${item['movie_id']},${item['jumlah']}|';
    });

    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/checkout.php"),
        body: {'user_id': activeuser, 'items': items});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sukses Checkout')));
        dbHelper.emptyCart().then((value) => _bacaData());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: _rsCart != null
                  ? ListView.builder(
                      itemCount: _rsCart?.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return _itemCart(index);
                      })
                  : const Text('belum ada data'),
            ),
            ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text("Check out")),
          ],
        ),
      ),
    );
  }
}
