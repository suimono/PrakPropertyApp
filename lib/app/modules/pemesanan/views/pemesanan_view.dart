import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/data/paket.dart';
import 'package:mobileapp/app/modules/pemesanan/controllers/pemesanan_controller.dart';

class PemesananView extends StatelessWidget {
  final PemesananController pemesananController =
      Get.put(PemesananController());
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Pemesanan'),
        actions: [
          IconButton(
            onPressed: () => _showDeleteConfirmationDialog(context),
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Obx(() => authC.isLoggedIn.value
          ? FutureBuilder(
              future: pemesananController.bacaKeranjang(authC.emailC.value),
              builder: (ctx, AsyncSnapshot<List<Paket>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Terjadi kesalahan: ${snapshot.error}'));
                }

                final List<Paket> paketList = snapshot.data ?? [];

                if (paketList.isEmpty) {
                  return Center(child: Text('Keranjang kosong'));
                }

                return ListView.builder(
                  itemCount: paketList.length,
                  itemBuilder: (ctx, index) {
                    final Paket paket = paketList[index];
                    return ListTile(
                      title: Text(paket.nama.value),
                      subtitle: Text('Harga: ${paket.harga.value}'),
                      trailing: ElevatedButton(
                        onPressed: () => pemesananController.checkoutPaket(
                            paket, authC.emailC.value),
                        child: Text('Checkout'),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: Text("Silahkan Login Terlebih Dahulu"))),
    );
  }

  // Function to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus semua barang di keranjang?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              pemesananController.hapusKeranjang(authC.emailC.value);
              Navigator.of(ctx).pop(); // Close the dialog
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
