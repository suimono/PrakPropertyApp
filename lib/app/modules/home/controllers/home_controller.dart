import 'package:get/get.dart';
import 'package:mobileapp/app/services/paket_controller.dart';
import 'package:mobileapp/app/data/paket.dart';

class HomeController extends GetxController {
  final String asset = "assets/logo.png";
  final RxInt selectedIndexBottomBar = 0.obs;

  // Injeksi PaketController (source of all data)
  final PaketController paketService = Get.find<PaketController>();

  // NOTE: Properti 'paket' lokal yang redundant telah dihapus.
  // Properti ini hanya fokus pada state navigasi dan data tampilan utama.

  void changePage(int index) {
    selectedIndexBottomBar.value = index;
  }

  // Computed Property: Mengambil 3 paket pertama langsung dari PaketController.
  // Getter ini reaktif (berfungsi seperti Obx) karena paketService.paketList adalah RxList.
  List<Paket> get firstThreePaket {
    // Menggunakan .take(3) untuk membatasi tampilan di halaman Home
    return paketService.paketList.take(3).toList();
  }
  
  // NOTE: Fungsi loadPaket() dan panggilannya di onInit() dihapus/disederhanakan,
  // karena PaketController sudah menjalankan fetchPaket() di onInit-nya sendiri.

  @override
  void onInit() {
    super.onInit();
    print('HomeController initialized, relying on PaketController for data.');
  }

  @override 
  void onClose() {
    // Hanya perlu menutup properti Observable yang didefinisikan di controller ini.
    selectedIndexBottomBar.close();
    
    print('HomeController disposed');
    super.onClose();
  }
  
  get isDarkMode => null;
  get toggleTheme => null;
}
