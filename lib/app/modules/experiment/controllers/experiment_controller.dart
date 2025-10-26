import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ExperimentController extends GetxController {
  final log = ''.obs;

  // Reuse instances
  final httpClient = http.Client();
  late final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.plain, // lebih cepat untuk ukur network
      headers: {'Connection': 'keep-alive'},
    ),
  );

  final String url = 'https://jsonplaceholder.typicode.com/posts/1';
  final int runs = 10;
  final int warmups = 2;

  @override
  void onClose() {
    httpClient.close();
    dio.close(force: true);
    super.onClose();
  }

  Future<int> _measureNetworkFuture(Future<void> Function() fn) async {
    final sw = Stopwatch()..start();
    try {
      await fn();
    } catch (e) {
      // biar error tetap tercatat tapi waktu stop
      log.value += 'Error: $e\n';
    } finally {
      sw.stop();
    }
    return sw.elapsedMilliseconds;
  }

  Future<void> _httpRequest({bool includeDecode = false}) async {
    final res = await httpClient.get(
      Uri.parse(url),
      headers: {'Connection': 'keep-alive'},
    );
    if (res.statusCode != 200) {
      throw Exception('HTTP Error: ${res.statusCode}');
    }
    if (includeDecode) {
      jsonDecode(res.body);
    }
  }

  Future<void> _dioRequest({bool includeDecode = false}) async {
    final res = await dio.get(url); // responseType.plain -> String
    if (res.statusCode != 200) {
      throw Exception('Dio Error: ${res.statusCode}');
    }
    if (includeDecode) {
      jsonDecode(res.data as String);
    }
  }

  Map<String, double> _stats(List<int> xs) {
    final n = xs.length;
    final mean = xs.reduce((a, b) => a + b) / n;
    final sorted = [...xs]..sort();
    double median = n.isOdd
        ? sorted[n ~/ 2].toDouble()
        : (sorted[n ~/ 2 - 1] + sorted[n ~/ 2]) / 2.0;
    int p = (0.95 * (n - 1)).round();
    final p95 = sorted[max(0, min(p, n - 1))].toDouble();
    return {'mean': mean, 'median': median, 'p95': p95};
  }

  Future<void> runExperiment() async {
    log.value = '🔍 Menjalankan eksperimen (fair benchmark)...\n';
    log.value += '- runs: $runs, warmups: $warmups\n';
    log.value += '- release mode sangat dianjurkan\n\n';

    // 1) Warm-up (tidak dihitung)
    for (int i = 0; i < warmups; i++) {
      await _httpRequest(includeDecode: false);
      await _dioRequest(includeDecode: false);
    }

    // 2) Eksekusi runs dengan urutan acak per iterasi
    final httpTimes = <int>[];
    final dioTimes = <int>[];

    final rand = Random();
    for (int i = 0; i < runs; i++) {
      final runOrder = rand.nextBool() ? 'HTTP-DIO' : 'DIO-HTTP';

      if (runOrder == 'HTTP-DIO') {
        final tHttp = await _measureNetworkFuture(
          () => _httpRequest(includeDecode: false),
        );
        httpTimes.add(tHttp);
        log.value += 'HTTP Run ${i + 1}: ${tHttp}ms\n';

        final tDio = await _measureNetworkFuture(
          () => _dioRequest(includeDecode: false),
        );
        dioTimes.add(tDio);
        log.value += 'DIO  Run ${i + 1}: ${tDio}ms\n\n';
      } else {
        final tDio = await _measureNetworkFuture(
          () => _dioRequest(includeDecode: false),
        );
        dioTimes.add(tDio);
        log.value += 'DIO  Run ${i + 1}: ${tDio}ms\n';

        final tHttp = await _measureNetworkFuture(
          () => _httpRequest(includeDecode: false),
        );
        httpTimes.add(tHttp);
        log.value += 'HTTP Run ${i + 1}: ${tHttp}ms\n\n';
      }
    }

    final httpStat = _stats(httpTimes);
    final dioStat = _stats(dioTimes);

    log.value += '---------------------------\n';
    log.value += '📊 HASIL AKHIR (network only):\n';
    log.value +=
        'HTTP → mean: ${httpStat['mean']!.toStringAsFixed(2)} ms | median: ${httpStat['median']!.toStringAsFixed(2)} | p95: ${httpStat['p95']!.toStringAsFixed(2)}\n';
    log.value +=
        'DIO  → mean: ${dioStat['mean']!.toStringAsFixed(2)} ms | median: ${dioStat['median']!.toStringAsFixed(2)} | p95: ${dioStat['p95']!.toStringAsFixed(2)}\n\n';

    if (dioStat['mean']! < httpStat['mean']!) {
      log.value += '✅ Kesimpulan: DIO lebih cepat pada pengukuran ini.\n';
    } else if (dioStat['mean']! > httpStat['mean']!) {
      log.value += '✅ Kesimpulan: HTTP lebih cepat pada pengukuran ini.\n';
    } else {
      log.value += '✅ Kesimpulan: Keduanya setara pada pengukuran ini.\n';
    }

    log.value +=
        '\nℹ️ Catatan: angka bisa bervariasi karena kondisi jaringan. Coba ulang beberapa kali atau ganti endpoint untuk validasi.';
  }
}
