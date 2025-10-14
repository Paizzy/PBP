import 'package:flutter/material.dart';
import '../cart_data.dart';

class MakananList extends StatelessWidget {
  final List<Map<String, dynamic>> makanan = [
    {
      "nama": "Nasi Putih",
      "harga": 2000,
      "gambar": "assets/images/nasi_putih.jpg",
    },
    {
      "nama": "Tahu Goreng",
      "harga": 1000,
      "gambar": "assets/images/tahu_goreng.jpeg",
    },
    {
      "nama": "Tempe Goreng",
      "harga": 1000,
      "gambar": "assets/images/tempe_goreng.jpg",
    },
    {
      "nama": "Ayam Goreng",
      "harga": 5000,
      "gambar": "assets/images/ayam_goreng.jpg",
    },
    {
      "nama": "Telur Dadar",
      "harga": 3000,
      "gambar": "assets/images/telur_dadar.jpeg",
    },
    {
      "nama": "Telur Mata Sapi",
      "harga": 3000,
      "gambar": "assets/images/telur_matasapi.jpeg",
    },
    {
      "nama": "Telur Rebus",
      "harga": 3000,
      "gambar": "assets/images/telur_rebus.jpeg",
    },
    {"nama": "Perkedel", "harga": 3000, "gambar": "assets/images/perkedel.jpg"},
    {
      "nama": "Bakwan Jagung",
      "harga": 3000,
      "gambar": "assets/images/bakwan_jagung.jpeg",
    },
    {
      "nama": "Sayur Lodeh",
      "harga": 5000,
      "gambar": "assets/images/sayur_lodeh.jpg",
    },
    {
      "nama": "Sayur Asem",
      "harga": 4000,
      "gambar": "assets/images/sayur_asem.jpg",
    },
    {"nama": "Capcay", "harga": 3000, "gambar": "assets/images/capcay.jpg"},
    {
      "nama": "Tumis Kangkung",
      "harga": 3000,
      "gambar": "assets/images/tumis_kangkung.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: makanan.length,
        itemBuilder: (context, index) {
          final item = makanan[index];
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
