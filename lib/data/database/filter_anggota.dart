import 'package:data_warga/data/models/anggota.dart';

class FilterAnggota {
  static const all = "";
  static const usiaProduktif =
      ''' $_umurQuery BETWEEN 22 and 50 GROUP BY "${Anggota.kolomJK}" ''';
  static const usiaLansia =
      ''' $_umurQuery > 60 GROUP BY "${Anggota.kolomJK}" ''';
  static const usiaSekolah =
      ''' $_umurQuery BETWEEN 8 and 22 GROUP BY "${Anggota.kolomJK}" ''';
  static const usiaBalita =
      ''' $_umurQuery < 5 GROUP BY "${Anggota.kolomJK}" ''';
  static String nama(val) =>
      " ${Anggota.tableName}.${Anggota.kolomNAMA} LIKE '%$val%' ";
  static String noRumah(val) =>
      " ${Anggota.tableName}.${Anggota.kolomNORUMAH} LIKE '%$val%'";

  static const orderNama = "${Anggota.tableName}.${Anggota.kolomNAMA}";
  static const orderNomerRumah = "${Anggota.tableName}.${Anggota.kolomNORUMAH}";
  static const orderTanggalLahir =
      "${Anggota.tableName}.${Anggota.kolomTGLLAHIR}";
  static const noOrder = "";
  static const orderDomisili = "${Anggota.tableName}.${Anggota.kolomDOMISILI}";

  static const _umurQuery = '''
    (strftime('%Y', 'now')
          - 
          strftime('%Y', ${Anggota.tableName}.${Anggota.kolomTGLLAHIR}))
          - 
          (strftime('%m-%d', 'now')
          < 
          strftime('%m-%d', ${Anggota.tableName}.${Anggota.kolomTGLLAHIR}))
  ''';
}
