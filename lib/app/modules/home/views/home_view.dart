// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors
// File: home_view.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/services/paket_controller.dart';
import 'package:mobileapp/app/modules/Gallery/controllers/gallery_controller.dart';
import 'package:mobileapp/app/modules/Gallery/views/gallery_view.dart';
import 'package:mobileapp/app/modules/home/controllers/home_controller.dart';
import 'package:mobileapp/app/modules/pemesanan/views/pemesanan_view.dart';
import 'package:mobileapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:mobileapp/app/modules/profil/views/profil_view.dart';
import 'package:mobileapp/app/modules/transaksi/views/transaksi_view.dart';
import 'package:mobileapp/app/routes/app_pages.dart';
import 'package:mobileapp/app/widgets/promo_banner_slider.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  late final PaketController paketC;
  late final GalleryController galleryC;

  @override
  Widget build(BuildContext context) {
    try {
      paketC = Get.find<PaketController>();
    } catch (e) {
      paketC = Get.put(PaketController());
    }

    try {
      galleryC = Get.find<GalleryController>();
    } catch (e) {
      galleryC = Get.put(GalleryController());
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      appBar: AppBar(
        toolbarHeight: 60,
        title: Image.asset(
          controller.asset,
          width: 100,
          height: 100,
        ),
      ),
      body: SafeArea( // ✅ Tambahkan supaya tombol bisa disentuh dan tidak ketimpa
        child: Obx(() {
          return IndexedStack(
            index: controller.selectedIndexBottomBar.value,
            children: [
              _buildHomePage(context),
              PemesananView(),
              PencarianView(),
              TransaksiView(),
              ProfilView(),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedIndexBottomBar.value,
          unselectedItemColor: Colors.black,
          selectedItemColor: const Color.fromRGBO(60, 42, 152, 1),
          type: BottomNavigationBarType.fixed,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc_text), label: 'Transaction'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    final List<String> bannerPaths = [
      'assets/promo1.jpg',
      'assets/promo2.jpg',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PromoBannerSlider(banners: bannerPaths),
            const SizedBox(height: 10),
            _buildIconRow(),
            const SizedBox(height: 25),
            _buildTitleRow('Daftar Paket', PencarianView()),
            const SizedBox(height: 15),
            _buildPackageList(),
            const SizedBox(height: 15),
            _buildTitleRow('Gallery', GalleryView()),
            const SizedBox(height: 15),
            _buildPackageList2(),
            const SizedBox(height: 30),

            // ✅ Tombol Eksperimen HTTP vs Dio
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  print("🧪 Tombol Eksperimen ditekan"); // debug log
                  Get.toNamed(Routes.EXPERIMENT); // navigasi ke halaman eksperimen
                },
                icon: const Icon(Icons.science, color: Colors.white),
                label: const Text(
                  'Eksperimen HTTP vs Dio',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(60, 42, 152, 1),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildIconContainer(
            Icons.roofing,
            "Mini Property",
            () => Get.toNamed(Routes.MINI_PAGE),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: _buildIconContainer(
            Icons.home,
            "Medium Property",
            () => Get.toNamed(Routes.MEDIUM_PAGE),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: _buildIconContainer(
            Icons.house,
            "Large Property",
            () => Get.toNamed(Routes.LARGE_PAGE),
          ),
        ),
      ],
    );
  }

  Widget _buildIconContainer(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: const Color.fromRGBO(60, 42, 152, 1),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(String title, Widget targetPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double fontSize = 20;
                if (constraints.maxWidth < 180) fontSize = 18;
                return Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () => Get.to(() => targetPage),
            child: const Text(
              'Lihat Semua',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(60, 42, 152, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageList() {
    return Obx(() {
      final paketSubset = controller.firstThreePaket;

      if (paketC.paketList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (paketSubset.isEmpty) {
        return const Center(child: Text('Belum ada paket yang tersedia'));
      }

      return SizedBox(
        height: 329,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: paketSubset.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                _buildPackageContainer(paketSubset[index]),
                const SizedBox(width: 13),
              ],
            );
          },
        ),
      );
    });
  }

  Widget _buildPackageContainer(var paket) {
    dynamic unwrap(dynamic val) => (val is Rx) ? val.value : val;

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PAKETDETAIL, arguments: paket),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 226,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(unwrap(paket.image) ?? ''),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unwrap(paket.nama)?.toString() ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  _buildInfoRow(Icons.date_range_outlined, unwrap(paket.tanggal)),
                  const SizedBox(height: 5),
                  _buildInfoRow(Icons.balcony_outlined, unwrap(paket.fasilitas)),
                  const SizedBox(height: 10),
                  _buildPriceRow(unwrap(paket.harga)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageList2() {
    return Obx(() {
      if (galleryC.galleryItems.isEmpty) {
        return const Center(child: Text('Belum ada dokumentasi yang tersedia'));
      }
      return SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: galleryC.galleryItems.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                _buildPackageContainer2(galleryC.galleryItems[index]),
                const SizedBox(width: 13),
              ],
            );
          },
        ),
      );
    });
  }

  Widget _buildPackageContainer2(Map<String, String> gallery) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 226,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(gallery['image']!),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              gallery['title']!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(dynamic harga) {
    dynamic unwrap(dynamic val) => (val is Rx) ? val.value : val;
    final raw = unwrap(harga)?.toString() ?? '0';
    final parsed = int.tryParse(raw) ?? 0;

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formattedPrice = formatter.format(parsed);

    return Row(
      children: [
        const Icon(Icons.monetization_on_outlined, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          formattedPrice,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, dynamic text) {
    dynamic unwrap(dynamic val) => (val is Rx) ? val.value : val;
    final textVal = unwrap(text)?.toString() ?? '';
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            textVal,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
