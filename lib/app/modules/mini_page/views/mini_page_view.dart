import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobileapp/app/modules/pencarian/controllers/pencarian_controller.dart';
import 'package:mobileapp/app/routes/app_pages.dart';

import '../controllers/mini_page_controller.dart';

class MiniPageView extends GetView<MiniPageController> {
final PencarianController pencarianC = Get.put(PencarianController());

  MiniPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mini Property"),
      ),
      body: Column(
        children: [
          // Display filtered packages
          Expanded(
            child: Obx(() {
              var paketList = pencarianC.filteredMini;

              // If the list is empty, show a loading indicator or message
              if (paketList.isEmpty) {
                return Center(child: Text("No packages found"));
              }

              return ListView.builder(
                itemCount: paketList.length,
                itemBuilder: (context, index) {
                  var paket = paketList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: SizedBox(
                        width: 120,  // Increased width for a larger image
                        height: 120,  // Increased height for a larger image
                        child: Image.asset(
                          paket.image.value, // Package image
                          fit: BoxFit.contain,  // Ensures image is fully displayed without cropping
                        ),
                      ),
                      title: Text(
                        paket.nama.value, // Package name
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal: ${paket.tanggal}'),
                          Text('Fasilitas: ${paket.fasilitas}'),
                          Text('Lokasi: ${paket.lokasi}'),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () => Get.toNamed(Routes.PAKETDETAIL,arguments: paket),

                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
