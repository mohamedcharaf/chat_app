// ignore_for_file: unused_import, implementation_imports, unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Qr code") ,
        
      ),
  body: Center(
  child: SingleChildScrollView(
    child: Card(
      child: QrImage(
        data: '123456789',
        version: QrVersions.auto,
        size: 200.0

        
      ),
    ),
  ),
),

    );
  }
}