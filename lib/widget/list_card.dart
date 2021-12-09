import 'package:data_warga/data/models/anggota.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardAnggota({required Anggota anggota}) => Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              anggota.nama,
              style: Get.theme.textTheme.headline6!.apply(fontWeightDelta: 2),
            ),
            const SizedBox(
              height: 8,
            ),
            _rowCard("NIK", anggota.nik),
            _rowCard("Jenis Kelamin", anggota.jk),
            _rowCard("Tanggal Lahir", anggota.tglLahir),
            _rowCard("Status", anggota.status),
            _rowCard("No. Rumah", anggota.noRumah),
            _rowCard("Pekerjaan", anggota.pekerjaan),
            _rowCard("Domisili", anggota.domisili),
            _rowCard("RT", anggota.rt),
            _rowCard("RW", anggota.rw),
            _rowCard("Alamat", anggota.alamat),
          ],
        ),
      ),
    );

Widget _rowCard(String key, String value) => SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text("$key ",
                  style: Get.theme.textTheme.bodyText2!
                      .apply(fontWeightDelta: 1))),
          Expanded(
            flex: 2,
            child: Text(": $value", style: Get.theme.textTheme.bodyText2),
          ),
        ],
      ),
    );
