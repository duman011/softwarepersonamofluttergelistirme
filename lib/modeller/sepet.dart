import 'package:flutter/foundation.dart';
import 'urun.dart';

class Sepet extends ChangeNotifier {
  final Map<Urun, int> _urunler = {};
  Map<Urun, int> get urunler => Map.unmodifiable(_urunler);
  int get adet => _urunler.values.fold(0, (toplam, adet) => toplam + adet);
  int get toplam => _urunler.entries.fold(
    0,
    (toplam, satir) => toplam + satir.key.fiyat * satir.value,
  );

  void ekle(Urun urun) {
    _urunler.update(urun, (adet) => adet + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void azalt(Urun urun) {
    final adet = _urunler[urun];
    if (adet == null) return;
    if (adet == 1) {
      _urunler.remove(urun);
    } else {
      _urunler[urun] = adet - 1;
    }
    notifyListeners();
  }

  void sil(Urun urun) {
    _urunler.remove(urun);
    notifyListeners();
  }
}
