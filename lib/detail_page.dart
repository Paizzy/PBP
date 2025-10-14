import 'package:flutter/material.dart';
import 'menu_item.dart';

class DetailPage extends StatelessWidget {
  final MenuItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.nama)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text("Harga: Rp ${item.harga}"),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
