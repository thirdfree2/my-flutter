import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/psychologist_screens/psychologist_sent_page.dart';
import 'package:flutter_application_1/view/screens/chat_screen_page.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../components/button.dart';
import '../../utils/api_url.dart';
import '../../utils/config.dart';
import 'dart:convert';

class PsyHomePage extends StatefulWidget {
  final token;
  const PsyHomePage({@required this.token, super.key});

  @override
  State<PsyHomePage> createState() => _PsyHomePageState();
}

class _PsyHomePageState extends State<PsyHomePage> {
  late String email;
  late int docid;
  late String name;

  List<dynamic> appointment = [];
  Future<void> fetchAppointment() async {
    final path = ApiUrls.localhost;
    final apiUrl = '$path/appointment/psychologist/$docid';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final AppointmentData = jsonData['data'];

      setState(() {
        appointment = AppointmentData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    docid = jwtDecodedToken['id'];
    debugPrint('Doctor Details Page - User_id: $docid');
    fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$name",
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Config.primaryColor,
        toolbarHeight: 100,
        elevation: 15,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text("Incoming Appointment"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appointment.length,
                itemBuilder: (BuildContext context, int index) {
                  if (appointment.isEmpty) {
                    return Center(
                      child: Text("Appointment Not Found"),
                    );
                  }
                  final appointmentToday = appointment[index];
                  final chat_id = appointmentToday['id'];
                  final user_id = appointmentToday['user_id'];
                  final appoint_time = appointmentToday['slot_time'];
                  final appoint_date = appointmentToday['slot_date'];
                  final status = appointmentToday['text_status'];
                  if (status != "Incoming") {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: FlutterLogo(size: 80.0),
                                ),
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '$user_id',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: PopupMenuButton<String>(
                                              onSelected: (String choice) {
                                                if (choice == 'Option 1') {
                                                  Get.to(WriteInsurtion(
                                                    apppintmentID: chat_id,
                                                    patientID: user_id,
                                                    senderID: docid,
                                                  ));
                                                } else if (choice ==
                                                    'Option 2') {
                                                  // คำสั่งที่ต้องการให้ Option 2 ทำ
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return <PopupMenuEntry<String>>[
                                                  PopupMenuItem<String>(
                                                    value: 'Option 1',
                                                    child: Text(
                                                      'เขียนคำแนะนำ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem<String>(
                                                    value: 'Option 2',
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .red, // สีของ Option 2
                                                      ),
                                                    ),
                                                  ),
                                                  // เพิ่มตัวเลือกอื่น ๆ ตามต้องการ
                                                ];
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Text('Appointment Time : $appoint_time'),
                                      Text('Date : $appoint_date'),
                                    ],
                                  ),
                                ),
                                isThreeLine: true,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Button(
                                    width: 300,
                                    title: 'Start Chat',
                                    onPressed: () => {
                                          Get.to(ChatdocScreen(
                                            token: widget.token,
                                            sourceId: docid,
                                            target_id: user_id,
                                          ))
                                        },
                                    disable: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
