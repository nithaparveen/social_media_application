import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/edit_profile_screen/controller/edit_profile_controller.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key,
      required this.name,
      required this.dob,
      required this.phone,
      required this.location});

  final String name;
  final String dob;
  final String phone;
  final String location;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  var dobController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  DateTime now = DateTime.now();
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
    now = DateTime.parse(widget.dob);
    phoneController.text = widget.phone;
    locationController.text = widget.location;
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
        // centerTitle: true,
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Edit Photo",
                  style: GLTextStyles.poppinsStyl(
                      color: ColorTheme.brown, size: 20),
                ),
              ),
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
                          initialDateTime: now,
                          minimumDate: now.subtract(Duration(days: 36500)),
                          maximumDate: now.add(Duration(days: 180)),
                          dateOrder: DatePickerDateOrder.ymd,
                          onDateTimeChanged: (newDateTime) {
                            selectedDate =
                                DateFormat("yyyy-MM-dd").format(newDateTime);
                          }),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(width: .1))),
                    // ),
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
                            Provider.of<EditProfileController>(context,
                                    listen: false)
                                .update(
                                    nameController.text.trim(),
                                    selectedDate!,
                                    "+91${phoneController.text.trim()}",
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
