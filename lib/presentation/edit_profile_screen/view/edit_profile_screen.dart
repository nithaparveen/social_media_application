import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/edit_profile_screen/controller/edit_profile_controller.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.name,
    required this.dob,
    required this.phone,
    required this.location,
  }) : super(key: key);

  final String name;
  final String dob;
  final String phone;
  final String location;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController dobController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    locationController = TextEditingController(text: widget.location);
    selectedDate = DateTime.parse(widget.dob);
    dobController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .79),
                      child: Text(
                        "Name",
                        style:
                        GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .65),
                      child: Text(
                        "Date of Birth",
                        style:
                        GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: selectedDate,
                          minimumDate: DateTime.now().subtract(Duration(days: 36500)),
                          maximumDate: DateTime.now().add(Duration(days: 180)),
                          dateOrder: DatePickerDateOrder.ymd,
                          onDateTimeChanged: (newDateTime) {
                            setState(() {
                              selectedDate = newDateTime;
                              dobController.text = DateFormat('yyyy-MM-dd').format(newDateTime);
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .61),
                      child: Text(
                        "Phone Number",
                        style:
                        GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .73),
                      child: Text(
                        "Location",
                        style:
                        GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: ColorTheme.blue,
                          minWidth: size.width * .4,
                          height: size.height * .07,
                          onPressed: () {
                            Provider.of<EditProfileController>(context, listen: false).update(
                                nameController.text.trim(),
                                dobController.text.trim(),
                                phoneController.text.trim(),
                                locationController.text.trim(),
                                context);
                          },
                          child: Text(
                            "Save Changes",
                            style: GLTextStyles.leagueSpartan(
                                size: 18, color: ColorTheme.yellow),
                          ),
                        ),
                        MaterialButton(
                          color: ColorTheme.blue,
                          minWidth: size.width * .4,
                          height: size.height * .07,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: GLTextStyles.leagueSpartan(
                                size: 18, color: ColorTheme.yellow),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
