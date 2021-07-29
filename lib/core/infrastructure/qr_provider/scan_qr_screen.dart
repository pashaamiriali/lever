import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';

//FORMAT: "1234" hive number
Future<String> scanQrCode() async {
  ScanResult result = await BarcodeScanner.scan();
  if (result.format == BarcodeFormat.qr) {
    return result.rawContent;
  }
  return '';
}
