import 'package:flutter/material.dart';
import '../modeller/sepet.dart';

class SepetSayfasi extends StatelessWidget {
  const SepetSayfasi({super.key, required this.sepet});
  final Sepet sepet;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sepetim')),
    body: ListenableBuilder(
      listenable: sepet,
      builder: (context, _) {
        if (sepet.adet == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 72,
                    color: Color(0xFFB1B5C5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sepetin henüz boş',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  const Text('Beğendiğin ürünleri keşfet ve sepetine ekle.'),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, '/urunler'),
                    child: const Text('Ürünleri keşfet'),
                  ),
                ],
              ),
            ),
          );
        }
        final satirlar = sepet.urunler.entries.toList();
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: satirlar.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, sira) {
                  final urun = satirlar[sira].key;
                  final adet = satirlar[sira].value;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 90,
                            child: Image.asset(urun.gorsel),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  urun.ad,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(urun.fiyatYazisi),
                                Row(
                                  children: [
                                    IconButton(
                                      tooltip: 'Azalt',
                                      onPressed: () => sepet.azalt(urun),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),
                                    Text('$adet'),
                                    IconButton(
                                      tooltip: 'Artır',
                                      onPressed: () => sepet.ekle(urun),
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Ürünü sil',
                            onPressed: () => sepet.sil(urun),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Toplam (${sepet.adet} ürün)',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          '\$${sepet.toplam}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Color(0xFF737785),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Sepet simülasyonudur. Ödeme alınmaz.',
                            style: TextStyle(color: Color(0xFF737785)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
