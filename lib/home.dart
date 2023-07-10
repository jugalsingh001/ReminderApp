import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/delete_reminder.dart';
import 'package:reminder/set_reminder.dart';
import 'package:reminder/update_reminder.dart';
import 'package:reminder/view_reminder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int day = DateTime.now().weekday;
  int date = DateTime.now().day;
  var month = DateTime.now().month;
  String dayName = '';

  List<String> l1 = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<String> l2 = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Welcome to the reminder application',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              widget.username.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Today is ${l1[day - 1]}, ${date}th of ${l2[month - 1]}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const SetReminderPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.yellow[700],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B4FE3), Color(0xFF3739A6)],
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
                    child: const Text(
                      'Set Reminder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const UpdateReminderPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.purple[700],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3739A6), Color(0xFF8B4FE3)],
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
                    child: const Text(
                      'Update Reminder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const ViewReminderPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.purple[700],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3739A6), Color(0xFF8B4FE3)],
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
                    child: const Text(
                      'View Reminders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const DeleteReminderPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.yellow[700],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B4FE3), Color(0xFF3739A6)],
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
                    child: const Text(
                      'Delete Reminder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    // color: Colors.deepOrangeAccent[700],
                    gradient: const LinearGradient(
                      colors: [Color(0xFF004DD6), Color(0xD03FDDCC)],
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
