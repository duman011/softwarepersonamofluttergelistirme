import 'package:flutter/material.dart';
import 'modeller/sepet.dart';
import 'modeller/urun.dart';
import 'sayfalar/ana_sayfa.dart';
import 'sayfalar/urun_listesi_sayfasi.dart';
import 'sayfalar/urun_detay_sayfasi.dart';
import 'sayfalar/sepet_sayfasi.dart';

void main() => runApp(const KatalogUygulamasi());

class KatalogUygulamasi extends StatefulWidget {
  const KatalogUygulamasi({super.key});
  @override
  State<KatalogUygulamasi> createState() => _KatalogUygulamasiState();
}

class _KatalogUygulamasiState extends State<KatalogUygulamasi> {
  final sepet = Sepet();
  @override
  void dispose() {
    sepet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mini Katalog',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAFC),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3155D9)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAFAFC),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFE7E8EE)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE7E8EE)),
        ),
      ),
    ),
    routes: {
      '/': (_) => AnaSayfa(sepet: sepet),
      '/urunler': (_) => UrunListesiSayfasi(sepet: sepet),
      '/sepet': (_) => SepetSayfasi(sepet: sepet),
    },
    onGenerateRoute: (ayarlar) {
      if (ayarlar.name == '/urun' && ayarlar.arguments is Urun) {
        return MaterialPageRoute<void>(
          settings: ayarlar,
          builder: (_) =>
              UrunDetaySayfasi(urun: ayarlar.arguments! as Urun, sepet: sepet),
        );
      }
      return null;
    },
  );
}
