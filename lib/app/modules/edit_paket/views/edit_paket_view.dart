  // ignore_for_file: must_be_immutable, use_key_in_widget_constructors

  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:mobileapp/app/data/paket.dart';
  import 'package:mobileapp/app/services/paket_controller.dart';
  import 'package:image_picker/image_picker.dart';
  import 'dart:io';

  class EditPaketView extends StatelessWidget {
    final _formKey = GlobalKey<FormState>();
    final namaController = TextEditingController();
    final tanggalController = TextEditingController();
    final transportasiController = TextEditingController();
    final hotelController = TextEditingController();
    final hargaController = TextEditingController();
    final jenisController = TextEditingController();

    final PaketController controller = Get.find();
    File? selectedImage;
    String? selectedCategory;


    @override
    Widget build(BuildContext context) {
      final args = Get.arguments;
      final Paket? paket = args?['paket'];
      final int? index = args?['index'];

      // Isi data jika mode edit
      if (paket != null) {
        namaController.text = paket.nama.value;
        tanggalController.text = paket.tanggal.value;
        transportasiController.text = paket.fasilitas.value;
        hotelController.text = paket.lokasi.value;
        hargaController.text = paket.harga.toString();
        jenisController.text = paket.jenis.value;
        selectedCategory = paket.category.value;
      }

      Future<void> pickImage() async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImage = File(pickedFile.path);
        }
      }

      Future<void> pickDate(BuildContext context) async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          tanggalController.text = selectedDate.toIso8601String().split('T').first;
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(paket == null ? 'Tambah Paket' : 'Edit Paket'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Paket'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama paket wajib diisi';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: selectedImage != null
                        ? Image.file(selectedImage!, fit: BoxFit.cover)
                        : paket?.image.value != null
                            ? Image.network(paket!.image.value, fit: BoxFit.cover)
                            : Center(child: Text('Pilih Gambar')),
                  ),
                ),
                TextFormField(
                  controller: tanggalController,
                  readOnly: true,
                  onTap: () => pickDate(context),
                  decoration: InputDecoration(labelText: 'Tanggal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal wajib diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: transportasiController,
                  decoration: InputDecoration(labelText: 'Transportasi'),
                ),
                TextFormField(
                  controller: hotelController,
                  decoration: InputDecoration(labelText: 'Hotel'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(labelText: 'Kategori'),
                  items: ['Umroh', 'Haji', 'Trip']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategory = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori wajib dipilih';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Harga'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga wajib diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harga harus berupa angka';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jenisController,
                  decoration: InputDecoration(labelText: 'Jenis'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedPaket = Paket(
                        nama: namaController.text,
                        image: selectedImage?.path ?? paket?.image.value ?? '',
                        tanggal: tanggalController.text,
                        fasilitas: transportasiController.text,
                        lokasi: hotelController.text,
                        category: selectedCategory ?? '',
                        harga: int.parse(hargaController.text),
                        itinerary: '', // Tambahkan jika ada input itinerary
                        jenis: jenisController.text,
                      );

                      if (paket == null) {
                        controller.addPaket(updatedPaket);
                      } else {
                        controller.updatePaket(index!, updatedPaket);
                      }

                      Get.back();
                    }
                  },
                  child: Text(paket == null ? 'Simpan' : 'Perbarui'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
