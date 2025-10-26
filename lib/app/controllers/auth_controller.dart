// ignore_for_file: avoid_print



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoggedIn = false.obs;
  var imagePath = ''.obs;
  var userName = ''.obs;
  var emailC = ''.obs;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void signup(String email, String password, String username) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emailC.value = email;
      userName.value = username;
      isLoggedIn = true.obs;
      await _saveUserProfile();
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }




Future<void> updateUserName(String newName) async {
  
  if (newName.isNotEmpty) {
    userName.value = newName;  // Update nama pengguna di AuthController
    await _saveUserProfile();  // Menyimpan perubahan ke Firestore
    Get.snackbar('Update Profil', 'Nama pengguna berhasil diperbarui.');
  } else {
    Get.snackbar('Update Profil', 'Nama pengguna tidak boleh kosong.');
  }
}




  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true.obs;
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout()async{
    await FirebaseAuth.instance.signOut();
      isLoggedIn = false.obs;
  }

   Future<void> _saveUserProfile() async {
    if (emailC.value.isNotEmpty) {
      try {
        await _firestore.collection('users').doc(emailC.value).set({
          'userName': userName.value,
          'profileImagePath': imagePath.value,
          'email': emailC.value,
        }, SetOptions(merge: true));
        Get.snackbar('Simpan Profil', 'Profil berhasil disimpan.');
      } catch (e) {
        Get.snackbar('Simpan Profil', 'Gagal menyimpan data: ${e.toString()}');
      }
    }
  }

  Future<void> loadUserData() async {
    if (auth.currentUser != null) {
      emailC.value = auth.currentUser!.email!;
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(emailC.value).get(const GetOptions(source: Source.server));
        if (userDoc.exists) {
          userName.value = userDoc['userName'] ?? emailC.value.split('@')[0];
          imagePath.value = userDoc['profileImagePath'] ?? '';
          isLoggedIn.value = true;
        } else {
          Get.snackbar('Data Pengguna', 'Data pengguna tidak ditemukan.');
        }
        print(userName);
      } catch (e) {
        if(e is FirebaseException){
          if(e.message == "The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff."){

          Get.snackbar('Hi', 'error jaringanmu');
          }
        }
      }
    }
  }

  void loginAdmin(){
    Get.offAllNamed(Routes.ADMIN);
  }

}
