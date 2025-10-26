import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/data/paket.dart';

class TransaksiController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to read transactions for a user
  Future<List<Paket>> bacaTransaksi(String email) async {
    try {
      // Ambil data transaksi dari Firestore berdasarkan email pengguna
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(email)
          .collection('transactions')
          .orderBy('checkoutDate', descending: true)
          .get();

      // Map setiap dokumen transaksi menjadi objek Paket
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
      print("Error membaca data transaksi: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat membaca transaksi');
      return []; // Kembalikan list kosong jika terjadi error
    }
  }

  // Function to get the details of a single transaction
  Future<Paket> bacaDetailTransaksi(String email, String transactionId) async {
    try {
      // Ambil data transaksi tertentu berdasarkan transactionId
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(email)
          .collection('transactions')
          .doc(transactionId)
          .get();

      // Map dokumen menjadi objek Paket
      if (doc.exists) {
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
      } else {
        throw Exception('Transaksi tidak ditemukan');
      }
    } catch (e) {
      print("Error membaca detail transaksi: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat membaca detail transaksi');
      throw e; // Lemparkan error untuk ditangani lebih lanjut
    }
  }

  void hapusTransaksi(String email, String transactionId) async {
    try {
      // Menghapus transaksi berdasarkan email dan transactionId
      await _firestore
          .collection('users')
          .doc(email)
          .collection('transactions')
          .doc(transactionId)
          .delete();

      // Menampilkan pesan keberhasilan
      Get.snackbar(
        'Berhasil',
        'Transaksi berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Menampilkan pesan kesalahan
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan saat menghapus transaksi: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    // Function to get transaction summary for a user
    Future<Map<String, dynamic>> ringkasanTransaksi(String email) async {
      try {
        // Ambil total transaksi dan total harga dari koleksi transaksi
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(email)
            .collection('transactions')
            .get();

        int totalTransaksi = snapshot.docs.length;
        double totalHarga = snapshot.docs.fold(0.0, (sum, doc) {
          return sum + (doc['harga'] as double);
        });

        return {
          'totalTransaksi': totalTransaksi,
          'totalHarga': totalHarga,
        };
      } catch (e) {
        print("Error membaca ringkasan transaksi: $e");
        Get.snackbar(
            'Error', 'Terjadi kesalahan saat membaca ringkasan transaksi');
        return {'totalTransaksi': 0, 'totalHarga': 0.0};
      }
    }
  }
}
