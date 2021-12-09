class JK {
  static final jk = {1: "Laki-laki", 2: "Perempuan"};

  static String jkString(int id) => jk[id]!;
  static int jkID(String value) => jk.keys.firstWhere((k) => jk[k] == value);
}
