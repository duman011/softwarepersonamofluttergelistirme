import 'package:flutter/material.dart';
import '../modeller/urun.dart';
import '../modeller/sepet.dart';
import '../bilesenler/sepet_dugmesi.dart';

class UrunDetaySayfasi extends StatelessWidget {
  const UrunDetaySayfasi({super.key, required this.urun, required this.sepet});
  final Urun urun;
  final Sepet sepet;
  static const basliklar = {
    'chip': 'İşlemci',
    'material': 'Malzeme',
    'camera': 'Kamera',
    'display': 'Ekran',
    'battery': 'Pil',
    'id': 'Kimlik',
    'ports': 'Bağlantılar',
    'weight': 'Ağırlık',
    'design': 'Tasarım',
    'colors': 'Renkler',
    'screen': 'Ekran',
    'pencil': 'Kalem',
    'connectivity': 'Bağlantı',
    'case': 'Kasa',
    'brightness': 'Parlaklık',
    'gps': 'GPS',
    'feature': 'Özellik',
    'carbon': 'Karbon',
    'os': 'Sistem',
    'control': 'Kontrol',
    'audio': 'Ses',
    'driver': 'Sürücü',
    'cancellation': 'Gürültü engelleme',
    'materials': 'Malzeme',
    'home': 'Ev',
    'sensing': 'Algılama',
    'size': 'Boyut',
  };
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Ürün detayı'),
      actions: [SepetDugmesi(sepet: sepet)],
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F1F3),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Hero(
            tag: urun.kimlik,
            child: Image.asset(urun.gorsel, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          urun.kategori,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          urun.ad,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          urun.kisaAciklama,
          style: const TextStyle(color: Color(0xFF737785)),
        ),
        const SizedBox(height: 24),
        const Text(
          'Ürün hakkında',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(urun.aciklama, style: const TextStyle(height: 1.6)),
        const SizedBox(height: 24),
        const Text(
          'Teknik özellikler',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...urun.ozellikler.entries.map(
          (ozellik) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    basliklar[ozellik.key] ?? ozellik.key,
                    style: const TextStyle(color: Color(0xFF737785)),
                  ),
                ),
                Expanded(
                  child: Text(
                    ozellik.value,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                urun.fiyatYazisi,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                sepet.ekle(urun);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${urun.ad} sepete eklendi.'),
                    action: SnackBarAction(
                      label: 'Sepete git',
                      onPressed: () => Navigator.pushNamed(context, '/sepet'),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Sepete ekle'),
            ),
          ],
        ),
      ),
    ),
  );
}
