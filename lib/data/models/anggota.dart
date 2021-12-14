import 'package:data_warga/data/models/domisili.dart';
import 'package:data_warga/data/models/jenis_kelamin.dart';
import 'package:data_warga/data/models/pekerjaan.dart';
import 'package:data_warga/data/models/status.dart';

class Anggota {
  static const String tableName = 'anggota';
  static const String kolomNIK = 'NIK';
  static const String kolomNAMA = 'NAMA';
  static const String kolomTGLLAHIR = 'TGLLAHIR';
  static const String kolomNORUMAH = 'NORUMAH';
  static const String kolomRT = 'RT';
  static const String kolomRW = 'RW';
  static const String kolomALAMAT = 'ALAMAT';
  static const String kolomJK = 'JK';
  static const String kolomPEKERJAAN = 'PEKERJAAN';
  static const String kolomSTATUS = 'STATUS';
  static const String kolomDOMISILI = 'DOMISILI';
  static const String kolomCATATAN = 'CATATAN';

  String? nik;
  String nama;
  String tglLahir;
  String noRumah;
  String rt;
  String rw;
  String alamat;
  String jk;
  String pekerjaan;
  String status;
  String domisili;
  String? catatan;

  Anggota(
      {this.nik,
      required this.alamat,
      required this.domisili,
      required this.jk,
      required this.nama,
      required this.noRumah,
      required this.pekerjaan,
      required this.rt,
      required this.rw,
      required this.status,
      required this.tglLahir,
      this.catatan});

  factory Anggota.fromMap(Map map) => Anggota(
      nik: map[kolomNIK],
      alamat: map[kolomALAMAT],
      domisili: map[kolomDOMISILI] is int
          ? Domisili.domisiliString(map[kolomDOMISILI])
          : map[kolomDOMISILI],
      jk: map[kolomJK] is int ? JK.jkString(map[kolomJK]) : map[kolomJK],
      nama: map[kolomNAMA],
      noRumah: map[kolomNORUMAH],
      pekerjaan: map[kolomPEKERJAAN] is int
          ? Pekerjaan.pekerjaanString(map[kolomPEKERJAAN])
          : map[kolomPEKERJAAN],
      rt: map[kolomRT],
      rw: map[kolomRW],
      status: map[kolomSTATUS] is int
          ? Status.statusString(map[kolomSTATUS])
          : map[kolomSTATUS],
      tglLahir: map[kolomTGLLAHIR],
      catatan: map[kolomCATATAN]);

  Map<String, dynamic> toMap() => {
        kolomNIK: nik,
        kolomALAMAT: alamat,
        kolomDOMISILI: Domisili.domisiliID(domisili),
        kolomJK: JK.jkID(jk),
        kolomNAMA: nama,
        kolomNORUMAH: noRumah,
        kolomPEKERJAAN: Pekerjaan.pekerjaanID(pekerjaan),
        kolomRT: rt,
        kolomRW: rw,
        kolomSTATUS: Status.statusID(status),
        kolomTGLLAHIR: tglLahir,
        kolomCATATAN: catatan
      };

  Map<String, dynamic> toMapString() => {
        kolomNIK: nik,
        kolomALAMAT: alamat,
        kolomDOMISILI: domisili,
        kolomJK: jk,
        kolomNAMA: nama,
        kolomNORUMAH: noRumah,
        kolomPEKERJAAN: pekerjaan,
        kolomRT: rt,
        kolomRW: rw,
        kolomSTATUS: status,
        kolomTGLLAHIR: tglLahir,
        kolomCATATAN: catatan
      };

  factory Anggota.empty() => Anggota(
      nik: '',
      alamat: '',
      domisili: '',
      jk: '',
      nama: '',
      noRumah: '',
      pekerjaan: '',
      rt: '',
      rw: '',
      status: '',
      tglLahir: '',
      catatan: '');
}
