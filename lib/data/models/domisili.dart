class Domisili {
  static final domisili = {1: "DOMISILI", 2: "TDK. DOMISILI", 3: "KOS/KONTRAK"};

  static String domisiliString(int id) => domisili[id]!;
  static int domisiliID(String value) {
    return domisili.keys.firstWhere((k) => domisili[k] == value);
  }
}
