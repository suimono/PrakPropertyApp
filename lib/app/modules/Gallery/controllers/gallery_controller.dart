import 'package:get/get.dart';

class GalleryController extends GetxController {
  // List contoh data gallery
  var galleryItems = [
    {"title": "Dokumentasi Property-1", "image": "assets/ciwidey.jpg"},
    {"title": "Dokumentasi Property-2", "image": "assets/umrah.jpg"},
    {"title": "Dokumentasi Property-3", "image": "assets/akhir.jpg"},
    {"title": "Dokumentasi Property-4", "image": "assets/rat.jpg"},
  ].obs;

  // Menambah item gallery baru
  void addGalleryItem(Map<String, String> item) {
    galleryItems.add(item);
  }

  // Mengupdate item gallery berdasarkan index
  void updateGalleryItem(int index, Map<String, String> updatedItem) {
    if (index >= 0 && index < galleryItems.length) {
      galleryItems[index] = updatedItem;
    }
  }

  // Menghapus item gallery berdasarkan index
  void deleteGalleryItem(int index) {
    if (index >= 0 && index < galleryItems.length) {
      galleryItems.removeAt(index);
    }
  }

  // Mengambil item gallery berdasarkan index
  Map<String, String>? getGalleryItem(int index) {
    if (index >= 0 && index < galleryItems.length) {
      return galleryItems[index];
    }
    return null;
  }
}
