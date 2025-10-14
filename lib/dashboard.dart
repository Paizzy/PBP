import 'package:flutter/material.dart';
import 'menu_data_source.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'slider_data.dart';
import '../cart_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchText = '';
  String activeFilter = 'Semua';

  bool showFloatingCart = false;

  List<Map<String, dynamic>> get filteredMenuItems {
    List<Map<String, dynamic>> baseList = allMenuItems;

    // 1. Filter berdasarkan Kategori
    if (activeFilter == 'Makanan') {
      baseList = baseList.where((item) => isMakanan(item)).toList();
    } else if (activeFilter == 'Minuman') {
      baseList = baseList.where((item) => isMinuman(item)).toList();
    }

    // 2. Filter berdasarkan Teks Pencarian - Case-Insensitive
    if (searchText.isEmpty) {
      return baseList;
    }

    final lowerSearch = searchText.toLowerCase();

    return baseList.where((item) {
      final itemName = item['nama']?.toLowerCase() ?? '';
      return itemName.contains(lowerSearch);
    }).toList();
  }

  Widget _buildFilterButton(String text) {
    final isActive = activeFilter == text;
    final bool isStarFilter = text == 'Bintang 5';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        onPressed: isStarFilter
            ? null
            : () {
                setState(() {
                  activeFilter = text;
                });
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.orange : Colors.grey[200],
          foregroundColor: isActive ? Colors.white : Colors.black,
          elevation: isActive ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isStarFilter)
              const Icon(Icons.star, color: Colors.amber, size: 18),
            if (isStarFilter) const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // File: dashboard.dart (Ganti seluruh fungsi _buildGridItem)

  Widget _buildGridItem(Map<String, dynamic> item, BuildContext context) {
    return Card(
      elevation: 2, // Naikkan elevation agar Card lebih menonjol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ), // Sudut lebih bulat
      child: InkWell(
        onTap: () {
          // LOGIKA POP-UP DETAIL MENU (Tetap sama)
          showDialog(
            context: context,
            builder: (_) {
              final screenWidth = MediaQuery.of(context).size.width;
              final dialogWidth = screenWidth * 0.4;

              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: SizedBox(
                  width: dialogWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // KODE POP-UP DIALOG DETAIL (Tetap sama seperti perbaikan terakhir)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            item['gambar']!,
                            height: 270,
                            width: dialogWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ... (detail teks, harga, rating, tombol tutup)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      item['nama'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Rp ${item['harga']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text("5.0", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Tutup",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        // KONTEN GRID ITEM BARU (Sesuai Desain E-Commerce)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Area Gambar (Menggunakan Stack untuk Rating)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Gambar Menu
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.asset(
                      item['gambar']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Rating Bintang di Pojok Kanan Atas
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(
                          0.5,
                        ), // Latar belakang gelap transparan
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 12),
                          SizedBox(width: 3),
                          Text(
                            "5.0", // Placeholder Rating
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Area Teks dan Tombol
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 8,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Barang (Bold, Font Standard)
                  Text(
                    item['nama']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Harga Barang (Bold, Font Lebih Besar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Rp ${item['harga']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Harga Bold
                          fontSize: 16, // Harga Lebih Besar
                          color: Colors.black,
                        ),
                      ),

                      // Tombol Plus (+) di Pojok Kanan Bawah
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            cart.add(item);
                            setState(() {
                              showFloatingCart = true;
                            });

                            // Sembunyikan otomatis setelah 3 detik
                            Future.delayed(const Duration(seconds: 3), () {
                              if (mounted) {
                                setState(() {
                                  showFloatingCart = false;
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredMenuItems;
    final hasResults = filtered.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Website Bu Dar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Konten Scrollable (SLIDER, SEARCH, FILTER, GRID)
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SLIDER
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 280.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                        ),
                        items: sliderImages.asMap().entries.map((entry) {
                          int index = entry.key;
                          String item = entry.value;
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        item,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.6),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10.0,
                                      left: 10.0,
                                      child: Text(
                                        sliderCaptions[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 25),

                      // SEARCH BAR
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Cari menu makanan/minuman...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // FILTER BUTTONS
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildFilterButton('Semua'),
                            _buildFilterButton('Bintang 5'),
                            _buildFilterButton('Makanan'),
                            _buildFilterButton('Minuman'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Judul Menu
                      const Text(
                        'Semua Menu Kami',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // GRID VIEW
                      if (hasResults)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.4,
                              ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return _buildGridItem(filtered[index], context);
                          },
                        )
                      else if (searchText.isNotEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text(
                              "Menu tidak ditemukan.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (showFloatingCart)
            Positioned(
              bottom: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: showFloatingCart ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showFloatingCart = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "${cart.length} item di keranjang",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
