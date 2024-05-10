import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/core/constants/colors.dart';

import '../../core/constants/text_styles.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  final descriptionstyle =
      GoogleFonts.poppins(color: Colors.grey[500], fontWeight: FontWeight.bold);
  final titlestyle =
      GoogleFonts.poppins(color: ColorTheme.blue, fontWeight: FontWeight.bold);

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
          'Terms and Conditions',
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
                        "Welcome to ThingShare! Before you dive into the world of connecting with friends, sharing content, and exploring communities, it’s important to understand the terms and conditions governing your use of our platform. Please read the following carefully:",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Text("1. Acceptance of Terms", style: titlestyle),
                      Text(
                        "By accessing or using ThingShare, you agree to abide by these terms and conditions. If you do not agree with any part of these terms, you may not use our services.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("2. User Eligibility", style: titlestyle),
                      Text(
                        "You must be at least 13 years old to use ThingShare. If you are under 18, you must have the consent of a parent or guardian.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("3. Account Registration", style: titlestyle),
                      Text(
                        "You are required to create an account to use certain features of ThingShare. You agree to provide accurate and complete information during registration and to keep your account credentials secure.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("4. User Conduct", style: titlestyle),
                      Text(
                        "You agree to use ThingShare in a manner consistent with applicable laws and regulations. This includes refraining from posting harmful, abusive, or inappropriate content, and respecting the rights and privacy of others.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("5. Content Ownership", style: titlestyle),
                      Text(
                        "You retain ownership of the content you post on ThingShare, but by uploading content, you grant us a non-exclusive, transferable, sub-licensable, royalty-free, and worldwide license to use, reproduce, modify, adapt, publish, translate, distribute, and display such content.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("6. Privacy Policy", style: titlestyle),
                      Text(
                        "Your privacy is important to us. Our Privacy Policy outlines how we collect, use, and disclose your personal information. By using ThingShare, you consent to our collection and use of your data as described in the Privacy Policy.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("7. Intellectual Property Rights",
                          style: titlestyle),
                      Text(
                        "All trademarks, logos, and service marks displayed on ThingShare are the property of their respective owners. You may not use these marks without prior written permission.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("8. Termination", style: titlestyle),
                      Text(
                        "We reserve the right to suspend or terminate your account at any time, without prior notice or liability, for any reason, including breach of these terms.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("9. Disclaimer of Warranties", style: titlestyle),
                      Text(
                        "ThingShare is provided “as is” and “as available” without any warranties of any kind. We do not guarantee that our platform will be uninterrupted, secure, or error-free.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("10. Limitation of Liability", style: titlestyle),
                      Text(
                        " In no event shall Company be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of ThingShare.",
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 5),
                      Text("11. Changes to Terms", style: titlestyle),
                      Text(
                        "We reserve the right to modify or replace these terms at any time. Your continued use of ThingShare after any such changes constitutes acceptance of the new terms.",
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
