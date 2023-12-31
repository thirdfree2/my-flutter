import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/components/custom_appbar.dart';

import 'package:flutter_application_1/view/screens/calendarfix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../utils/config.dart';


class DoctorDetails extends StatefulWidget {
  final token;
  final int user_id;
  final psychologist_id;
  final psychologist_name;
  final status;
  const DoctorDetails(
      {@required this.psychologist_id,
      this.token,
      this.user_id = 0,
      this.psychologist_name,
      this.status,
      Key? key})
      : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isFav = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('Doctor Details Page - Docname: ${widget.psychologist_id}');
    debugPrint('Doctor Details Page - User_id: ${widget.user_id}');
    debugPrint('Doctor Details Page - token: ${widget.token}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Config.spaceSmall,
            const Spacer(),
            AboutDoctor(docname: widget.psychologist_name),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Start Booking',
                onPressed: () {
                  if (widget.status != 'InAppointment') {
                    // Get.to(CalendarFixSecond(
                    //     psychologist_id: widget.psychologist_id,
                    //     user_id: widget.user_id,
                    //     token: widget.token,
                    //     ));
                    // Get.to(BookingPage(
                    //   psychologist_id: widget.psychologist_id,
                    //   user_id: widget.user_id,
                    //   token: widget.token,
                    // ));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPagefix(
                            psychologist_id: widget.psychologist_id,
                            user_id: widget.user_id,
                            token: widget.token,
                          ),
                        ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('You have Appointmented'),
                            actions: <Widget>[
                              Button(
                                width: 100,
                                title: 'Exit',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                disable: false,
                              )
                            ],
                          );
                        });
                  }
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final String docname; // เพิ่มตัวแปร docname

  const AboutDoctor({Key? key, required this.docname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage('assets/images/doctor1.jpg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            '$docname',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: 350,
            child: const Text(
              'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: 350,
            child: const Text(
              'KU KPS Hospital',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          DetailBody(),
        ],
      ),
    );
  }
}

class DetailBody extends StatefulWidget {
  const DetailBody({super.key});

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          DoctorInfo(),
          Config.spaceBig,
          const Text(
            'About Doctor',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          Text(
            'Dr.Richard Tan is and express Dentist at Srawk',
            style: TextStyle(fontWeight: FontWeight.w500, height: 1.5),
            softWrap: true,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        InfoCard(label: 'Patients', value: '109'),
        SizedBox(
          width: 15,
        ),
        InfoCard(label: 'Experiences', value: '10 year'),
        SizedBox(
          width: 15,
        ),
        InfoCard(label: 'Rating', value: '4.0'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ]),
      ),
    );
  }
}
