import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:flutter_application_1/presentation/pages/qrgeneratot.dart';
import 'package:flutter_application_1/presentation/pages/qrscanner.dart';
import 'package:flutter_application_1/trasnlationbut.dart';

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Choose_Select.tr()),
        backgroundColor: MYColors.primaryColor, 
        actions: [
            TranslationButton(),
          ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildQRCard(
                context,
                LocaleKeys.Scan_a_Code.tr(),
                Icons.qr_code_scanner,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => Qrscanner())),
              ),
              SizedBox(height: 20),
              _buildQRCard(
                context,
                LocaleKeys.Add_Your_Code.tr(),
                Icons.qr_code,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeGenerator())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRCard(BuildContext context, String title, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: MYColors.blueGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, size: 80, color: MYColors.blueGreyColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}