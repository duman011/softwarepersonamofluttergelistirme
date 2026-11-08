class Urun {
  const Urun({
    required this.kimlik,
    required this.ad,
    required this.kisaAciklama,
    required this.aciklama,
    required this.fiyat,
    required this.gorsel,
    required this.kategori,
    required this.ozellikler,
  });

  final int kimlik;
  final String ad;
  final String kisaAciklama;
  final String aciklama;
  final int fiyat;
  final String gorsel;
  final String kategori;
  final Map<String, String> ozellikler;

  factory Urun.fromJson(Map<String, dynamic> json) => Urun(
    kimlik: json['kimlik'] as int,
    ad: json['ad'] as String,
    kisaAciklama: json['kisaAciklama'] as String,
    aciklama: json['aciklama'] as String,
    fiyat: json['fiyat'] as int,
    gorsel: json['gorsel'] as String,
    kategori: json['kategori'] as String,
    ozellikler: Map<String, String>.from(json['ozellikler'] as Map),
  );

  Map<String, dynamic> toJson() => {
    'kimlik': kimlik,
    'ad': ad,
    'kisaAciklama': kisaAciklama,
    'aciklama': aciklama,
    'fiyat': fiyat,
    'gorsel': gorsel,
    'kategori': kategori,
    'ozellikler': ozellikler,
  };
  String get fiyatYazisi => '\$$fiyat';
}
