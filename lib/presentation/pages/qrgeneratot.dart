import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String _dataString = "Hello, QR!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.QR_Code_Generator.tr()),
        backgroundColor: MYColors.primaryColor, 
      ),
      body: Container(
        color: MYColors.secondaryColor, 
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: _dataString,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: MYColors.secondaryColor, 
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _dataString = value;
                });
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.Enter_data.tr(),
                hintStyle: TextStyle(color: MYColors.blueGreyColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: MYColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: MYColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}