class Status {
  static final status = {
    1: "KK",
    2: "ISTRI",
    3: "ANAK",
    4: "FAMILY",
  };

  static String statusString(int id) => status[id]!;
  static int statusID(String value) =>
      status.keys.firstWhere((k) => status[k] == value);
}
