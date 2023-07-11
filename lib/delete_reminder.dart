import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteReminderPage extends StatefulWidget {
  const DeleteReminderPage({Key? key}) : super(key: key);

  @override
  State<DeleteReminderPage> createState() => _DeleteReminderPageState();
}

class _DeleteReminderPageState extends State<DeleteReminderPage> {
  TextEditingController title = TextEditingController();

  int? len = 0;
  List<String>? l1;
  List<String>? l2;
  List<String>? l3;
  List<String>? l4;
  List<String>? l5;

  Future<bool> getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    l1 = prefs.getStringList('items_title');
    l2 = prefs.getStringList('items_desc');
    l3 = prefs.getStringList('items_date');
    l4 = prefs.getStringList('items_time');
    l5 = prefs.getStringList('items_check');

    len = l1?.length;
    if (len == 0) {
      return false;
    }

    // prefs.remove('items_title');
    // prefs.remove('items_desc');
    // prefs.remove('items_date');
    // prefs.remove('items_time');
    // prefs.remove('items_check');

    for (int i = 0; i < len!; i++) {
      if (l1![i] == title.text.trim().toLowerCase()) {
        l1?.removeAt(i);
        l2?.removeAt(i);
        l3?.removeAt(i);
        l4?.removeAt(i);
        l5?.removeAt(i);
        break;
      }
      if (i == len! - 1) {
        return false;
      }
    }

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

    return true;
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
        title: const Text('Delete Reminder'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  10,
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
              TextButton(
                onPressed: () async {
                  if (title.text.trim().isEmpty) {
                    showInSnackBar(
                        value: 'Please enter the title', context: context);
                  } else {
                    Future<bool> f = getDetails();

                    if (await f) {
                      showInSnackBar(
                          value: 'Reminder deleted successfully',
                          context: context);
                      Navigator.pop(context);
                    } else {
                      showInSnackBar(
                          value: 'No such reminder exist', context: context);
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3547B6), Color(0xFF4567A6)],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
