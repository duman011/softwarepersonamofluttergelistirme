import 'package:flutter/material.dart';
import '../modeller/sepet.dart';
import '../modeller/urun.dart';
import '../veriler/katalog_verisi.dart';
import '../bilesenler/urun_karti.dart';
import '../bilesenler/sepet_dugmesi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, required this.sepet});
  final Sepet sepet;
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late Future<List<Urun>> urunler = urunleriYukle();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Mini Katalog',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      actions: [
        SepetDugmesi(sepet: widget.sepet),
        const SizedBox(width: 8),
      ],
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
        final oneCikanlar = sonuc.data!
            .where((urun) => [17, 18, 19, 20].contains(urun.kimlik))
            .toList();
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Keşfet',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Günlük hayatına eşlik edecek teknolojiler.',
              style: TextStyle(color: Color(0xFF737785)),
            ),
            const SizedBox(height: 22),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Navigator.pushNamed(context, '/urunler'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/gorseller/banner.png',
                  width: double.infinity,

                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Öne çıkanlar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/urunler'),
                  child: const Text('Tüm ürünler'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, sinirlar) => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: oneCikanlar.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: sinirlar.maxWidth > 700 ? 4 : 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, sira) =>
                    UrunKarti(urun: oneCikanlar[sira]),
              ),
            ),
          ],
        );
      },
    ),
  );
}
