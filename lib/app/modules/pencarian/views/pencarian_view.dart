// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/modules/pencarian/controllers/pencarian_controller.dart';
import 'package:mobileapp/app/routes/app_pages.dart';

class PencarianView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register the PencarianController
    Get.put(PencarianController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Pencarian Paket"),
        actions: [
          // Filter dropdown in the AppBar (left-aligned)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              // Dynamically set the filter text based on selectedFilter value
              String displayText = Get.find<PencarianController>().selectedFilter.value;
              return DropdownButton<String>(
                value: displayText,
                onChanged: (newValue) {
                  // Update the selected filter value in the controller
                  Get.find<PencarianController>().selectedFilter.value = newValue!;
                },
                items: <String>['All', 'Mini', 'Medium', 'Large']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display filtered packages
          Expanded(
            child: Obx(() {
              var paketList = Get.find<PencarianController>().filteredPaket;

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
