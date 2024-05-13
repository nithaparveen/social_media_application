import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final descriptionstyle =
      GoogleFonts.poppins(color: Colors.grey[500], fontWeight: FontWeight.bold);
  final titlestyle = GoogleFonts.poppins(
    color: ColorTheme.blue,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Privacy Policy',
        ),
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1.5,
                    )),
                width: MediaQuery.of(context).size.width * 0.99,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "At ThingShare, safeguarding your privacy is paramount. Here's a concise overview of how we handle your information:",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Text("1. Information Collection", style: titlestyle),
                      Text(
                        " We collect limited personal information like your name, email, and usage data to enhance your experience.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("2. Use of Information", style: titlestyle),
                      Text(
                        "Your data helps us operate and improve our services, communicate with you, and ensure a secure environment.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("3. Information Sharing ", style: titlestyle),
                      Text(
                        "We may share data with trusted partners, for legal reasons, or as per your privacy settings.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("4. Your Rights", style: titlestyle),
                      Text(
                        "You have control over your account settings, access to your data, and the right to request its deletion or correction.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("5. Data Security", style: titlestyle),
                      Text(
                        "We employ measures to protect your information but cannot guarantee absolute security.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("6. Children's Privacy", style: titlestyle),
                      Text(
                        " Our platform is not for children under 13, and we do not knowingly collect their data.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("7. Policy Changes", style: titlestyle),
                      Text(
                        "We may update this policy; continued use signifies your acceptance of changes.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
