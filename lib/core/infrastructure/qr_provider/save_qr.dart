import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<bool> saveQrCode(String data, String fileName) async {
  QrValidationResult qrValidationResult = getQrValidationResult(data);
  final qrCode = qrValidationResult.qrCode;
  QrPainter painter = paintQR(qrCode);
  //!doesn't work at the first attempt
  final picData =
      await painter.toImageData(2048, format: ui.ImageByteFormat.png);
  final buffer = picData.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  String path = '$tempPath/$fileName.png';
  try {
    await writeToFile(picData, path);
    bool result = await GallerySaver.saveImage(path, albumName: 'Lever');
    print(result);
    return result;
  } catch (e) {
    print(e);
  }
  return false;
}

QrPainter paintQR(QrCode qrCode) {
  final painter = QrPainter.withQr(
    emptyColor: Color(0xFFFFFFFF),
    qr: qrCode,
    color: Color(0xFF000000),
    gapless: true,
    embeddedImageStyle: null,
    embeddedImage: null,
  );
  return painter;
}

QrValidationResult getQrValidationResult(String data) {
  final qrValidationResult = QrValidator.validate(
    data: data,
    version: QrVersions.auto,
    errorCorrectionLevel: QrErrorCorrectLevel.L,
  );
  return qrValidationResult;
}

Future<void> writeToFile(ByteData data, String path) async {
  final buffer = data.buffer;
  await File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
