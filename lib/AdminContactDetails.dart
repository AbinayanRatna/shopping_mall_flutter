import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class AdminAddContacts extends StatefulWidget {
  const AdminAddContacts({super.key});

  @override
  State<AdminAddContacts> createState()  => _AdminAddContacts();
}

class _AdminAddContacts extends State<AdminAddContacts> {
  late DatabaseReference dbRef2;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('Contact_Details');
  late Query dbQuery;
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactJobController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  late String uuid;

  @override
  void initState() {
    super.initState();

    dbQuery = FirebaseDatabase.instance.ref().child('Contact_Details');
  }

  Widget listItem({required Map thisContact}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(229, 227, 221, 1.0)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        elevation: (0),
                        padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                        backgroundColor:
                            const Color.fromRGBO(201, 169, 101, 1.0)),
                    onPressed: () {},
                    child: Container(
                        child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                        child: Text(
                          thisContact['name'],
                          style: TextStyle(fontSize: 15.w, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.w),
                        child: Text(
                          thisContact['contact'],
                          style: TextStyle(fontSize: 15.w, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.w),
                        child: Text(
                          thisContact['job'],
                          style: TextStyle(fontSize: 15.w, color: Colors.black),
                        ),
                      )
                    ]))),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        elevation: (0),
                        padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                        backgroundColor:
                            const Color.fromRGBO(229, 227, 221, 1.0)),
                    onPressed: () {
                      dbRef.child(thisContact['id']).remove();
                    },
                    child: Text(
                      "Remove",
                      style: TextStyle(fontSize: 15.w, color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Add contact details",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(51, 110, 203, 1.0),
        toolbarHeight: 60.w,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 20.w, bottom: 20.w),
              child: Container(
                color: const Color.fromRGBO(213, 210, 210, 1.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text(
                              "Person name:",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.w),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.w, left: 30.w, right: 30.w),
                            child: TextField(
                              controller: contactNameController,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(194, 173, 129, 1.0)),
                                  hintText: "eg:- U. Sutharson"),
                              style: (TextStyle(
                                  color: Colors.indigo, fontSize: 15.w)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text(
                              "Person Job:",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.w),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.w, left: 30.w, right: 30.w),
                            child: TextField(
                              controller: contactJobController,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(194, 173, 129, 1.0)),
                                  hintText: "eg:- 1st floor Security"),
                              style: (TextStyle(
                                  color: Colors.indigo, fontSize: 15.w)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.w, left: 30.w),
                            child: Text(
                              "Contact Number:",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.w),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.w, left: 30.w, right: 30.w),
                            child: TextField(
                              controller: contactNumberController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(194, 173, 129, 1.0)),
                                  hintText: "eg:- 077XXXXXXX"),
                              style: (TextStyle(
                                  color: Colors.indigo, fontSize: 15.w)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero)),
                                  backgroundColor:
                                      const Color.fromRGBO(42, 65, 105, 1.0)),
                              onPressed: () {
                                if (contactNameController.text.trim().isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Name is empty",
                                      toastLength: Toast.LENGTH_SHORT);
                                } else if (contactNumberController.text
                                    .trim()
                                    .isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Number is empty",
                                      toastLength: Toast.LENGTH_SHORT);
                                } else if (contactJobController.text
                                    .trim()
                                    .isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Job is empty",
                                      toastLength: Toast.LENGTH_SHORT);
                                } else {
                                  setState(() {
                                    uuid = const Uuid().v4();
                                    dbRef2 = FirebaseDatabase.instance
                                        .ref()
                                        .child('Contact_Details')
                                        .child(uuid);
                                  });
                                  if (contactNumberController.text.length ==
                                      10) {
                                    Map<String, String> players = {
                                      'name': contactNameController.text.trim(),
                                      'contact': contactNumberController.text
                                          .toString(),
                                      'id': uuid,
                                      'job': contactJobController.text.trim()
                                    };
                                    dbRef2.set(players);
                                    contactJobController.text = "";
                                    contactNumberController.text = "";
                                    contactNameController.text = "";
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Invalid contact Number",
                                        toastLength: Toast.LENGTH_SHORT);
                                    contactJobController.text = "";
                                    contactNumberController.text = "";
                                    contactNameController.text = "";
                                  }
                                }
                              },
                              child: Text(
                                "Add Details",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.w),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.w),
              child: FirebaseAnimatedList(
                defaultChild: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 35.w,
                    width: 35.w,
                    child: const CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(25, 56, 133, 1.0),
                      valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                      strokeWidth: 10,
                    ),
                  ),
                ),
                query: dbQuery,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map contacts = snapshot.value as Map;
                  contacts['key'] = snapshot.key;
                  return listItem(thisContact: contacts);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
