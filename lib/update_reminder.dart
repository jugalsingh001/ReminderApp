import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

class UpdateReminderPage extends StatefulWidget {
  const UpdateReminderPage({Key? key}) : super(key: key);

  @override
  State<UpdateReminderPage> createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  NotificationsServices notificationsServices = NotificationsServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationsServices.initialiseNotifications();
  }

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  String dateTime = '';
  bool enabled = false;
  String timeDate = '';

  int? len = 0;
  List<String>? l1;
  List<String>? l2;
  List<String>? l3;
  List<String>? l4;
  List<String>? l5;

  Future<bool> getTitle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    l1 = prefs.getStringList('items_title');
    len = l1?.length;

    for (int i = 0; i < len!; i++) {
      if (l1![i] == title.text.trim().toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  void updateDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // l1 = prefs.getStringList('items_title');
    l2 = prefs.getStringList('items_desc');
    l3 = prefs.getStringList('items_date');
    l4 = prefs.getStringList('items_time');
    l5 = prefs.getStringList('items_check');

    // len = l1?.length;
    int i;
    for (i = 0; i < len!; i++) {
      if (l1![i] == title.text.trim().toLowerCase()) {
        l1![i] = title.text.trim().toLowerCase();
        l2![i] = desc.text.trim();
        l3![i] = dateTime;
        l4![i] = timeDate;
        l5![i] = 'true';
        break;
      }
      // if (i == len! - 1) {
      //   return false;
      // }
    }
    notificationsServices.stopNotifications(i + 1);

    await prefs.setStringList('items_title', l1!);
    await prefs.setStringList('items_desc', l2!);
    await prefs.setStringList('items_date', l3!);
    await prefs.setStringList('items_time', l4!);
    await prefs.setStringList('items_check', l5!);

    print(prefs.getStringList('items_title'));
    print(prefs.getStringList('items_desc'));
    print(prefs.getStringList('items_date'));
    print(prefs.getStringList('items_time'));
    print(prefs.getStringList('items_check'));

    List dt1 = dateTime.split('-');
    List td1 = timeDate.split(' ');
    List td2 = td1[0].split(':');

    List<int> dt2 = [];
    List<int> td3 = [];

    for (int i = 0; i < dt1.length; i++) {
      dt2.add(int.parse(dt1[i]));
    }
    print(dt2);

    for (int i = 0; i < td2.length; i++) {
      td3.add(int.parse(td2[i]));
    }
    print(td3);
    print(td1[1]);

    notificationsServices.sendNotification(i + 1, dt2[2], dt2[1], dt2[0],
        td3[0], td3[1], td1[1], title.text.toUpperCase(), desc.text);

    // return true;
  }

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    ).then((value) {
      setState(() {
        dateTime = value!.toString().substring(0, 10);
      });
    });
  }

  void selectTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        timeDate = value!.format(context).toString();
      });
    });
  }

  void showInSnackBar({required String value, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 5.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Reminder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Title: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: title,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter the title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          enabled
              ? Column(
                  children: [
                    const Text(
                      'Description: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: desc,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Enter the description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        selectDate();
                      },
                      height: 40,
                      color: Colors.blue[800],
                      textColor: Colors.white,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      onPressed: () {
                        selectTime();
                      },
                      height: 45,
                      color: Colors.blue[800],
                      child: const Text(
                        'Select Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      timeDate,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Container(),
          InkWell(
            onTap: () async {
              if (title.text.trim().isEmpty) {
                showInSnackBar(
                    value: 'Please enter the title', context: context);
              } else if (!enabled) {
                if (await getTitle()) {
                  setState(() {
                    enabled = true;
                  });
                } else {
                  showInSnackBar(
                      value: 'No such reminder exist', context: context);
                }
              } else if (desc.text.trim().isEmpty) {
                showInSnackBar(
                    value: 'Please enter the description', context: context);
              } else if (dateTime.isEmpty) {
                showInSnackBar(
                    value: 'Please enter the date', context: context);
              } else if (timeDate.isEmpty) {
                showInSnackBar(
                    value: 'Please enter the time', context: context);
              } else if (enabled) {
                updateDetails();
                showInSnackBar(
                    value: 'Reminder updated successfully', context: context);
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3547B6), Color(0xFF4567A6)],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
