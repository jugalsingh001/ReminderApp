import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

class ViewReminderPage extends StatefulWidget {
  const ViewReminderPage({Key? key}) : super(key: key);

  @override
  State<ViewReminderPage> createState() => _ViewReminderPageState();
}

class _ViewReminderPageState extends State<ViewReminderPage> {
  NotificationsServices notificationsServices = NotificationsServices();

  int? len = 0;
  List<String>? keys;
  List<String>? description;
  List<String>? date;
  List<String>? tim;
  List<String>? check;

  void getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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

    setState(() {
      len = keys?.length;
    });
    print(prefs.getStringList('items_title'));
  }

  void setReminder(int id, String str) {
    List dt1 = date![id].split('-');
    List td1 = tim![id].split(' ');
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

    if (str == 'false') {
      notificationsServices.stopNotifications(id + 1);
    } else {
      notificationsServices.sendNotification(id + 1, dt2[2], dt2[1], dt2[0],
          td3[0], td3[1], td1[1], keys![id], description![id]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    notificationsServices.initialiseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Reminder'),
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
          itemCount: len,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/reminder.png',
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        '${keys![index].substring(0, 1).toUpperCase()}${keys![index].substring(1).toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        description![index],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Checkbox(
                        value: check![index] == 'true',
                        // value: isChecked[index],
                        onChanged: (bool? value) async {
                          setState(() {
                            if (check![index] == 'true') {
                              check![index] = 'false';
                              setReminder(index, 'false');
                            } else {
                              check![index] = 'true';
                              setReminder(index, 'true');
                            }
                          });
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setStringList('items_check', check!);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 60,
                        ),
                        Text(
                          'Date: ${date![index]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          'Time: ${tim![index]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
