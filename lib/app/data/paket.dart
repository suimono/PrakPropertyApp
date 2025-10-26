import 'package:get/get.dart';

class Paket {
  RxString nama;
  RxString image;
  RxString tanggal;
  RxString fasilitas;
  RxString lokasi;
  RxString category;
  RxInt harga;
  RxString itinerary;
  RxString jenis;

  Paket({
    required String nama,
    required String image,
    required String tanggal,
    required String fasilitas,
    required String lokasi,
    required String category,
    required int harga,
    required String itinerary,
    required String jenis,
  })  : nama = nama.obs,
        image = image.obs,
        tanggal = tanggal.obs,
        fasilitas = fasilitas.obs,
        lokasi = lokasi.obs,
        category = category.obs,
        harga = harga.obs,
        itinerary = itinerary.obs,
        jenis = jenis.obs;
}
