import 'dart:convert';
import 'package:flutter/services.dart';
import '../modeller/urun.dart';

Future<List<Urun>> urunleriYukle() async {
  final metin = await rootBundle.loadString('assets/veriler/urunler.json');
  return (jsonDecode(metin) as List)
      .map((veri) => Urun.fromJson(veri as Map<String, dynamic>))
      .toList();
}
