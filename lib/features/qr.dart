/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrToStringScreen extends StatefulWidget {
  @override
  _QrToStringScreenState createState() => _QrToStringScreenState();
}

class _QrToStringScreenState extends State<QrToStringScreen> {
  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قراءة QR Code')),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) async {
                await controller.stop();
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty)
                  BlocProvider.of<attendanceworkersCubit>(context)
                      .changescanner(barcodes.first.rawValue!, context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
*/