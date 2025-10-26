import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/modules/Gallery/controllers/gallery_controller.dart';
import 'package:mobileapp/app/modules/edit_gallery/views/edit_gallery_view.dart';

class AdminGalleryView extends StatelessWidget {
  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.galleryItems.length,
          itemBuilder: (context, index) {
            final item = controller.galleryItems[index];
            return ListTile(
              title: Text(item['title'] ?? ''),
              subtitle: Text(item['image'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigasi ke halaman edit dengan data item yang dipilih
                      Get.to(() => EditGalleryView(), arguments: {'item': item, 'index': index});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.deleteGalleryItem(index);
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
          // Navigasi ke halaman edit tanpa data (untuk tambah item baru)
          Get.to(() => EditGalleryView(), arguments: {'item': null, 'index': null});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
