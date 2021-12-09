class Pekerjaan {
  static final pekerjaan = {
    1: "PNS",
    2: "SWASTA",
    3: "WRSWASTA",
    4: "BURUH",
    5: "TDK.KERJA"
  };

  static String pekerjaanString(int id) => pekerjaan[id]!;
  static int pekerjaanID(String value) =>
      pekerjaan.keys.firstWhere((k) => pekerjaan[k] == value);
}
