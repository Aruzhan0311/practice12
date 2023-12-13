import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:flutter_application_1/presentation/bloc/qr/scanner_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/qr/scanner_event.dart';
import 'package:flutter_application_1/presentation/bloc/qr/scanner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qrscanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ScannerBloc(),
        child: QR(),
      ),
    );
  }
}

class QR extends StatefulWidget {
  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  StreamSubscription? _scanSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.QR_ode_Scanner),
        backgroundColor: MYColors.primaryColor, 
      ),
      body: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: MYColors.blueColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: state is ScanCompletedState
                      ? Text('Data: ${state.data}', style: TextStyle(color: Colors.black))
                      : CircularProgressIndicator(), 
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller?.toggleFlash();
          setState(() {});
        },
        child: Icon(Icons.flash_on),
        backgroundColor: MYColors.blueGreyColor,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    _scanSubscription = controller.scannedDataStream.listen((scanData) {
      if (mounted) {
        BlocProvider.of<ScannerBloc>(context).add(ScanCompleted(scanData.code!));
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    _scanSubscription?.cancel(); 
    super.dispose();
  }
}