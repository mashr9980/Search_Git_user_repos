import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanQr extends StatefulWidget {
  const ScanQr({Key key}) : super(key: key);

  @override
  _ScanQrState createState() => _ScanQrState();
}
String barcode;
final _outputController = TextEditingController();
class _ScanQrState extends State<ScanQr> {
  Future _scan() async {
    await Permission.camera.request();
    barcode = await scanner.scan();
    if (barcode == null) {
      if (kDebugMode) {
        print('nothing return.');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(barcode),
              ),
            );
      // print(barcode);
      // _outputController.text = barcode;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Repositories List"),
      ),
      body: InkWell(
        onTap: (){
          _scan();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.qr_code,color: Theme.of(context).primaryColor,size: 80,),
              const Text("Tap To Scan the code",style: TextStyle(fontSize: 16),),
              // const Divider(color: Colors.grey,),
              // Container(
              //   height: 52,
              //   child: Text(_outputController.text),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
