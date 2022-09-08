import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _phone = TextEditingController();

class _HomePageState extends State<HomePage> {
  _callNumber(String phoneNumber) async {
    String number = phoneNumber;

    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: _phone,
                decoration: const InputDecoration(hintText: "PhoneNumber"),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    _callNumber(_phone.text);
                  },
                  child: const Text("Call")),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    _makePhoneCall(_phone.text);
                  },
                  child: const Text("Go to Default App")),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_phone.text.isNotEmpty) {
                    Share.share(_phone.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Filed Empty"),
                    ));
                  }
                },
                child: const Text("Share"),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
