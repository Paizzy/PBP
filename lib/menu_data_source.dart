import 'components/makanan_list.dart';
import 'components/minuman_list.dart';

// 1. Ambil data mentah dari list-list yang sudah ada
final List<Map<String, dynamic>> allMakanan = MakananList().makanan;
final List<Map<String, dynamic>> allMinuman = MinumanList().minuman;

// 2. Gabungkan semua menu menjadi satu list utama untuk pencarian
final List<Map<String, dynamic>> allMenuItems = [...allMakanan, ...allMinuman];

// 3. Fungsi untuk mengecek apakah suatu item adalah Makanan atau Minuman
bool isMakanan(Map<String, dynamic> item) {
  return allMakanan.contains(item);
}

bool isMinuman(Map<String, dynamic> item) {
  return allMinuman.contains(item);
}
