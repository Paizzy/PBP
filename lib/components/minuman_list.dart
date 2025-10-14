import 'package:flutter/material.dart';
import '../cart_data.dart';

class MinumanList extends StatelessWidget {
  final List<Map<String, dynamic>> minuman = [
    {"nama": "Es Teh", "harga": 4000, "gambar": "assets/images/es_teh.jpg"},
    {
      "nama": "Teh Hangat",
      "harga": 3000,
      "gambar": "assets/images/teh_hangat.jpg",
    },
    {
      "nama": "Es Jeruk",
      "harga": 5000,
      "gambar": "assets/images/es_jeruk.jpeg",
    },
    {
      "nama": "Jeruk Hangat",
      "harga": 4000,
      "gambar": "assets/images/jeruk_hangat.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: minuman.length,
        itemBuilder: (context, index) {
          final item = minuman[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(item['nama'] ?? ''),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(item['gambar']!, height: 120),
                      ),
                      const SizedBox(height: 10),
                      Text("Harga: Rp ${item['harga']}"),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        cart.add(item);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${item['nama']} ditambahkan ke keranjang",
                            ),
                          ),
                        );
                      },
                      child: const Text("Tambah ke Keranjang"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item['gambar']!,
                      height: 100,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['nama']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Rp ${item['harga']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
