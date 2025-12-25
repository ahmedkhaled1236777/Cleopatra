import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/qc/presentation/view/addqc.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class Qcscanner extends StatefulWidget {
  @override
  State<Qcscanner> createState() => _QcscannerState();
}

class _QcscannerState extends State<Qcscanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  getdata() async {
    if (BlocProvider.of<injectionhallcuibt>(context).orders.isEmpty)
      await BlocProvider.of<injectionhallcuibt>(
        context,
      ).getinjection(status: false);
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<injectionhallcuibt, injectionhalltates>(
        builder: (context, state) {
          if(state is getinjectionhalltatefailure)return Text(state.error_message);
          if(state is getinjectionhalltateloading)return loading();
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "برجاء مسح باركود الماكينه",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "cairo",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (BlocProvider.of<injectionhallcuibt>(context).qcmap[scanData.code!
              .split('')
              .last] ==
          null) {
        showdialogerror(error: "هذا الباركود غير صحيح", context: context);
      } else {
        navigateandfinish(
          context: context,
          page: Addqc(machinenumber: scanData.code!.split('').last),
        );
      }
    });
  }
}
