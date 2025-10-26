import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/data/paket.dart';

class PemesananController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to save item to the cart
  void simpanKeranjang(String email, Paket paket) async {
    try {
      DocumentReference docRef = _firestore
          .collection('users')
          .doc(email)
          .collection('cartItems')
          .doc();  // Auto generate document ID

      await docRef.set({
        'nama': paket.nama.value,
        'jenis': paket.jenis.value,
        'tanggal': paket.tanggal.value,
        'fasilitas': paket.fasilitas.value,
        'lokasi': paket.lokasi.value,
        'harga': paket.harga.value,
        'image': paket.image.value,
        'category' : paket.category.value,
        'itinerary' : paket.itinerary.value
      });

      print("Item berhasil ditambahkan ke Firestore dengan ID: ${docRef.id}");
      Get.snackbar('Berhasil', 'Paket ditambahkan ke keranjang');
    } catch (e) {
      print("Error menyimpan item ke Firestore: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat menambahkan ke keranjang');
    }
  }

  // Function to read cart items for a user
  Future<List<Paket>> bacaKeranjang(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(email)
          .collection('cartItems')
          .get();

      List<Paket> paketList = snapshot.docs.map((doc) {
        return Paket(
          nama: doc['nama'],
          jenis: doc['jenis'],
          tanggal: doc['tanggal'],
          fasilitas: doc['fasilitas'],
          lokasi: doc['lokasi'],
          harga: doc['harga'],
          image: doc['image'],
          category: doc['category'],
          itinerary: doc['itinerary'],
        );
      }).toList();

      return paketList;
    } catch (e) {
      print("Error membaca item dari keranjang: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat membaca keranjang');
      return [];
    }
  }

  // Function to delete cart item by document ID
  void hapusKeranjang(String email) async {
      try {
    // Ambil semua dokumen di dalam koleksi cartItems
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(email)
        .collection('cartItems')
        .get();

    // Loop untuk menghapus setiap dokumen
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    Get.forceAppUpdate();
    print("Semua item di keranjang berhasil dihapus.");
    Get.snackbar('Berhasil', 'Semua item di keranjang telah dihapus');
  } catch (e) {
    print("Error menghapus semua item di keranjang: $e");
    Get.snackbar('Error', 'Terjadi kesalahan saat menghapus keranjang');
  }
  }

  // Function to checkout and save to transaction
  void checkoutPaket(Paket paket, String email) async {
    try {
      DocumentReference docRef = _firestore
          .collection('users')
          .doc(email)
          .collection('transactions')
          .doc(); // Auto-generate document ID

      await docRef.set({
        'nama': paket.nama.value,
        'jenis': paket.jenis.value,
        'tanggal': paket.tanggal.value,
        'fasilitas': paket.fasilitas.value,
        'lokasi': paket.lokasi.value,
        'harga': paket.harga.value,
        'image': paket.image.value,
        'category': paket.category.value,
        'itinerary': paket.itinerary.value,
        'checkoutDate': FieldValue.serverTimestamp(),
      });

      print("Paket berhasil di-checkout dengan ID transaksi: ${docRef.id}");
      Get.snackbar('Berhasil', 'Paket berhasil di-checkout');

      // Optionally, remove the item from the cart after checkout
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(email)
          .collection('cartItems')
          .where('nama', isEqualTo: paket.nama.value)
          .get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print("Paket berhasil dihapus dari keranjang setelah checkout.");
    } catch (e) {
      print("Error saat checkout paket: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat checkout');
    }
  }
}
