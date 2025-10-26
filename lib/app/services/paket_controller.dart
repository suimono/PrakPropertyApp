import 'package:get/get.dart';
import 'package:mobileapp/app/data/paket.dart';

class PaketController extends GetxController {
  // Observable list untuk menampung data paket
  var paketList = <Paket>[].obs;

  @override
  void onInit() {
    // onInit harus sinkron. Panggil fungsi async tanpa 'await'.
    super.onInit();
    fetchPaket(); 
  }

  Future<void> fetchPaket() async {
    // Simulasi penundaan dari API
    await Future.delayed(Duration(seconds: 2));

    // Langsung gunakan literal integer untuk harga
    var initialdata = [
      Paket(
          nama: 'Rumah 1',
          image: 'assets/content-1.jpg',
          tanggal: '2025-09-30', 
          fasilitas: '3 Betroom, Swimming POol',
          lokasi: 'Lamongan',
          category: 'Mini',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Mini"),
      Paket(
          nama: 'Rumah 4',
          image: 'assets/content-4.jpg',
          tanggal: '2025-10-15', 
          fasilitas: '3 Betroom, Swimming POol ',
          lokasi: 'Dinoyo',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 2',
          image: 'assets/content-2.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming POol',
          lokasi: 'Sukomulyo',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 3',
          image: 'assets/content-3.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming POol',
          lokasi: 'Jakarta',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 5',
          image: 'assets/content-5.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Surabaya',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 6',
          image: 'assets/content-6.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Gresik',
          category: 'Large',
          harga: 195000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 7',
          image: 'assets/content-7.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Mojokerto',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 8',
          image: 'assets/content-8.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Pasuruan',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'Rumah 9',
          image: 'assets/content-9.jpg',
          tanggal: '2025-11-25', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Jombang',
          category: 'Large',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Large"),
      Paket(
          nama: 'rumah 10',
          image: 'assets/content-1.jpg',
          tanggal: '2025-07-01', 
          fasilitas: '3 Betroom, Swimming Pool',
          lokasi: 'Surabaya',
          category: 'Medium',
          harga: 750000000, // Perbaikan: Gunakan literal integer
          itinerary: "",
          jenis: "Medium"),
    ];
    // .addAll() otomatis memicu rebuild, tidak perlu .refresh()
    paketList.addAll(initialdata);
  }

  void addPaket(Paket paket) {
    paketList.add(paket);
    // paketList.refresh(); <-- Dihapus
  }

  void updatePaket(int index, Paket updatedPaket) {
    if (index < paketList.length) {
      // Modifikasi item dengan indeks akan memicu rebuild otomatis
      paketList[index] = updatedPaket;
      // paketList.refresh(); <-- Dihapus
    }
  }

  void deletePaket(int index) {
    if (index < paketList.length) {
      paketList.removeAt(index);
      // paketList.refresh(); <-- Dihapus
    }
  }
}