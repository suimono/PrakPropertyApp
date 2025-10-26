import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/modules/edit_paket/views/edit_paket_view.dart';
import 'package:mobileapp/app/services/paket_controller.dart';
// import 'add_paket_page.dart';

class AdminPaketView extends StatelessWidget {
  final PaketController controller = Get.put(PaketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Paket')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.paketList.length,
          itemBuilder: (context, index) {
            final paket = controller.paketList[index];
            return ListTile(
              title: Text(paket.nama.value),
              subtitle: Text('Rp ${paket.harga.toString()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigasi ke halaman edit
                      Get.to(() => EditPaketView(), arguments: {'paket': paket, 'index': index});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.deletePaket(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EditPaketView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
