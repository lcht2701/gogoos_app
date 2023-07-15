import 'package:flutter/material.dart';

class MomoQrCodeScreen extends StatelessWidget {
  const MomoQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Momo QR Code',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image(
                  image: AssetImage('assets/images/momo_qr.jpg'),
                  fit: BoxFit.fitHeight,
                  height: 500,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Transfer content: {Your email} - Gogoos Premium",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2),
            Text(
              "For example: abc@gmail.com - Gogoos Premium",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2),
            Text(
              "Once done, please wait 5 minutes and then return to the app!",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
