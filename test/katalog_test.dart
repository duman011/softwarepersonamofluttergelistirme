import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';
import 'package:mini_katalog/modeller/sepet.dart';
import 'package:mini_katalog/modeller/urun.dart';
import 'package:mini_katalog/veriler/katalog_verisi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('JSON ve görseller yüklenir, model dönüşümü veriyi korur', () async {
    final urunler = await urunleriYukle();
    expect(urunler.length, 20);
    expect(urunler.map((urun) => urun.kimlik).toSet().length, 20);
    for (final urun in urunler) {
      expect(Urun.fromJson(urun.toJson()).toJson(), urun.toJson());
      expect(urun.fiyat, greaterThan(0));
    }
  });

  test('Sepette miktar, toplam ve silme tutarlıdır', () async {
    final urunler = await urunleriYukle();
    final sepet = Sepet();
    addTearDown(sepet.dispose);
    sepet.ekle(urunler[0]);
    sepet.ekle(urunler[0]);
    sepet.ekle(urunler[1]);
    expect(sepet.adet, 3);
    expect(sepet.toplam, 2 * urunler[0].fiyat + urunler[1].fiyat);
    sepet.azalt(urunler[0]);
    sepet.sil(urunler[1]);
    expect(sepet.adet, 1);
    sepet.azalt(urunler[0]);
    sepet.azalt(urunler[0]);
    expect(sepet.toplam, 0);
    expect(sepet.urunler, isEmpty);
  });

  testWidgets('Katalog araması, detay, sepete ekleme ve silme çalışır', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(420, 920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.runAsync(() async {
      await tester.pumpWidget(const KatalogUygulamasi());
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    final banner = tester.widget<Image>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/gorseller/banner.png',
      ),
    );
    expect(banner.fit, BoxFit.contain);
    expect(banner.height, isNull);
    await tester.runAsync(() async {
      await tester.tap(find.text('Tüm ürünler'));
      await tester.pump();
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'olmayan ürün');
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('Aramanıza uygun ürün bulunamadı.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'iPhone 15 Pro');
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('1 ürün'), findsOneWidget);
    await tester.tap(find.text('iPhone 15 Pro').last);
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('Ürün detayı'), findsOneWidget);
    await tester.tap(find.text('Sepete ekle'));
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Sepetim'));
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('Toplam (1 ürün)'), findsOneWidget);
    await tester.tap(find.byTooltip('Artır'));
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('Toplam (2 ürün)'), findsOneWidget);
    await tester.tap(find.byTooltip('Ürünü sil'));
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    });
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
