import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({Key? key}) : super(key: key);

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  // TextEditingController date = TextEditingController();

  // TextEditingController time = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  static List<String>? keys;
  static List<String>? description;
  static List<String>? date;
  static List<String>? tim;
  static List<String>? check;

  String dateTime = '';
  String timeDate = '';
  // String time = '';

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
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
        title: const Text('Set Reminder'),
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
              top: 10,
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
              top: 10,
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
            height: 15,
          ),
          MaterialButton(
            onPressed: () {
              selectDate();
            },
            height: 45,
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
          InkWell(
            onTap: () async {
              if (title.text.trim().isEmpty) {
                showInSnackBar(value: 'Please enter title', context: context);
              } else if (desc.text.trim().isEmpty) {
                showInSnackBar(
                    value: 'Please enter description', context: context);
              } else if (dateTime.isEmpty) {
                showInSnackBar(value: 'Please enter date', context: context);
              } else if (timeDate.isEmpty) {
                showInSnackBar(value: 'Please enter time', context: context);
              } else {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                keys = prefs.getStringList('items_title');
                description = prefs.getStringList('items_desc');
                date = prefs.getStringList('items_date');
                tim = prefs.getStringList('items_time');
                check = prefs.getStringList('items_check');

                if (keys == null || keys == 'null' || keys == '') {
                  keys = [];
                  description = [];
                  date = [];
                  tim = [];
                  check = [];
                }

                keys?.add(title.text.trim().toLowerCase());
                description?.add(desc.text);
                date?.add(dateTime);
                tim?.add(timeDate);
                check?.add('true');

                await prefs.setStringList('items_title', keys!);
                await prefs.setStringList('items_desc', description!);
                await prefs.setStringList('items_date', date!);
                await prefs.setStringList('items_time', tim!);
                await prefs.setStringList('items_check', check!);

                print(prefs.getStringList('items_title'));
                print(prefs.getStringList('items_desc'));
                print(prefs.getStringList('items_date'));
                print(prefs.getStringList('items_time'));
                print(prefs.getStringList('items_check'));

                showInSnackBar(
                    value: 'Reminder set successfully', context: context);
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3547B6), Color(0xFF4567A6)],
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text(
                'Set',
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
