import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/data/paket.dart';
import 'package:mobileapp/app/modules/transaksi/controllers/transaksi_controller.dart';

class TransaksiView extends StatelessWidget {
  final TransaksiController transaksiController =
      Get.put(TransaksiController());
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Transaksi Saya'),
        // Menghapus IconButton delete dari AppBar
      ),
      body: Obx(() => authC.isLoggedIn.value
          ? FutureBuilder(
              future: transaksiController.bacaTransaksi(authC.emailC.value),
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
                  return Center(child: Text('Belum ada transaksi.'));
                }

                return ListView.builder(
                  itemCount: paketList.length,
                  itemBuilder: (ctx, index) {
                    final Paket paket = paketList[index];
                    return ListTile(
                      title: Text(paket.nama.value),  // Mengakses nama dari Rx<String> dengan .value
                      subtitle: Text('Harga: ${paket.harga}'),
                    );
                  },
                );
              },
            )
          : Center(child: Text("Silahkan Login Terlebih Dahulu"))),
    );
  }
}
