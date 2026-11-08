import 'package:flutter/material.dart';
import '../modeller/urun.dart';
import '../modeller/sepet.dart';
import '../veriler/katalog_verisi.dart';
import '../bilesenler/urun_karti.dart';
import '../bilesenler/sepet_dugmesi.dart';

class UrunListesiSayfasi extends StatefulWidget {
  const UrunListesiSayfasi({super.key, required this.sepet});
  final Sepet sepet;
  @override
  State<UrunListesiSayfasi> createState() => _UrunListesiSayfasiState();
}

class _UrunListesiSayfasiState extends State<UrunListesiSayfasi> {
  late Future<List<Urun>> urunler = urunleriYukle();
  String arama = '';
  String kategori = 'Tümü';
  String kucult(String metin) =>
      metin.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Ürünler'),
      actions: [SepetDugmesi(sepet: widget.sepet)],
    ),
    body: FutureBuilder<List<Urun>>(
      future: urunler,
      builder: (context, sonuc) {
        if (sonuc.hasError) {
          return Center(
            child: FilledButton(
              onPressed: () => setState(() => urunler = urunleriYukle()),
              child: const Text('Yeniden dene'),
            ),
          );
        }
        if (!sonuc.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final liste = sonuc.data!
            .where(
              (urun) =>
                  (kategori == 'Tümü' || urun.kategori == kategori) &&
                  kucult(
                    '${urun.ad} ${urun.kategori}',
                  ).contains(kucult(arama.trim())),
            )
            .toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: TextField(
                onChanged: (deger) => setState(() => arama = deger),
                decoration: const InputDecoration(
                  hintText: 'Ürün ara',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 46,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children:
                    [
                          'Tümü',
                          ...sonuc.data!.map((urun) => urun.kategori).toSet(),
                        ]
                        .map(
                          (ad) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(ad),
                              selected: kategori == ad,
                              onSelected: (_) => setState(() => kategori = ad),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${liste.length} ürün',
                  style: const TextStyle(color: Color(0xFF737785)),
                ),
              ),
            ),
            Expanded(
              child: liste.isEmpty
                  ? const Center(
                      child: Text('Aramanıza uygun ürün bulunamadı.'),
                    )
                  : LayoutBuilder(
                      builder: (context, sinirlar) => GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: liste.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: sinirlar.maxWidth > 700 ? 4 : 2,
                          mainAxisExtent: 250,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, sira) =>
                            UrunKarti(urun: liste[sira]),
                      ),
                    ),
            ),
          ],
        );
      },
    ),
  );
}
