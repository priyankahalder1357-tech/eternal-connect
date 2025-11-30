import 'package:flutter/material.dart';

void main() {
  runApp(EternalConnectApp());
}

// ----------------------
// Main App
// ----------------------
class EternalConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eternal Connect',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LoginScreen(),
    );
  }
}

// ----------------------
// 1️⃣ LOGIN SCREEN
// ----------------------
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black38,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("Login with Google"),
                onPressed: () {
                  // After Google login, go to Language Screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LanguageScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.indigo[400],
    );
  }
}

// ----------------------
// 2️⃣ LANGUAGE SELECTION
// ----------------------
class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Language")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PurposeScreen("English")),
                );
              },
              child: Text("English"),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PurposeScreen("Bangla")),
                );
              },
              child: Text("Bangla"),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PurposeScreen("Hindi")),
                );
              },
              child: Text("Hindi"),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------
// 3️⃣ PURPOSE SELECTION
// ----------------------
class PurposeScreen extends StatelessWidget {
  final String language;
  PurposeScreen(this.language);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Purpose")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Language: $language"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RelationConsentScreen(purpose: "Talk with deceased"),
                  ),
                );
              },
              child: Text("Talk with deceased person"),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RelationConsentScreen(purpose: "Therapy"),
                  ),
                );
              },
              child: Text("Therapy use"),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------
// 4️⃣ RELATION & FAMILY CONSENT
// ----------------------
class RelationConsentScreen extends StatefulWidget {
  final String purpose;
  RelationConsentScreen({required this.purpose});

  @override
  _RelationConsentScreenState createState() => _RelationConsentScreenState();
}

class _RelationConsentScreenState extends State<RelationConsentScreen> {
  String? relation;
  bool consent = false;
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController guardianNameController = TextEditingController();
  final TextEditingController guardianPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Relation & Consent")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("Purpose: ${widget.purpose}"),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Relation"),
              items: [
                "Father",
                "Mother",
                "Grandfather",
                "Grandmother",
                "Other",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) {
                setState(() {
                  relation = val;
                });
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: yourNameController,
              decoration: InputDecoration(labelText: "Your Name"),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: guardianNameController,
              decoration: InputDecoration(labelText: "Guardian Name"),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: guardianPhoneController,
              decoration: InputDecoration(labelText: "Guardian Phone"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            CheckboxListTile(
              value: consent,
              onChanged: (val) {
                setState(() {
                  consent = val!;
                });
              },
              title: Text("Family consent given"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  consent &&
                      relation != null &&
                      yourNameController.text.isNotEmpty &&
                      guardianNameController.text.isNotEmpty &&
                      guardianPhoneController.text.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OTPVerificationScreen(
                            guardianPhone: guardianPhoneController.text,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------
// 5️⃣ OTP VERIFICATION
// ----------------------
class OTPVerificationScreen extends StatelessWidget {
  final String guardianPhone;
  OTPVerificationScreen({required this.guardianPhone});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "An OTP has been sent to guardian phone: $guardianPhone (simulate)",
            ),
            SizedBox(height: 12),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => UploadDataScreen()),
                );
              },
              child: Text("Agree Terms & Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------
// 6️⃣ UPLOAD PHOTO & VOICE
// ----------------------
class UploadDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Data")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.photo),
              label: Text("Upload Photo"),
              onPressed: () {},
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.mic),
              label: Text("Upload Voice Note"),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => AIInteractionScreen()),
                );
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------
// 7️⃣ AI INTERACTION / THERAPY
// ----------------------
class AIInteractionScreen extends StatefulWidget {
  @override
  _AIInteractionScreenState createState() => _AIInteractionScreenState();
}

class _AIInteractionScreenState extends State<AIInteractionScreen> {
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add("You: ${messageController.text}");
      });

      // Simulate AI reply
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          messages.add("AI: I am here with you. Tell me what you feel.");
        });
      });

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Therapy Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, index) => ListTile(title: Text(messages[index])),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: "Type your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: sendMessage, child: Text("Send")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
