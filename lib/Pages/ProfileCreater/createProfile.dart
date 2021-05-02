
import 'package:flutter/material.dart';
import 'package:soughted/Pages/ProfileCreater/MenteeProfileOverView.dart';
import 'package:soughted/Pages/ProfileCreater/MentorEducationInfo.dart';
import 'package:soughted/Pages/ProfileCreater/MentorPersnalIInfo.dart';
import 'package:soughted/Pages/ProfileCreater/MentorWorkInfo.dart';
import 'package:soughted/Pages/ProfileCreater/QuickApplication.dart';
import 'package:soughted/Pages/ProfileCreater/WorkInfo.dart';
import 'package:soughted/Pages/ProfileCreater/persnalIInfo.dart';
import 'package:soughted/Pages/ProfileCreater/skills.dart';

import 'MentorProfileOverView.dart';
import 'UplodCV.dart';
import 'UserType.dart';



import 'educationalInfo.dart';


class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();

}
class _CreateProfileState extends State<CreateProfile> {
  int slideIndex = 0;
  PageController controller;


  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isIOS;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                physics:new NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  Usertype(controller,slideIndex),
                  PersnalIInfo(controller,slideIndex),
                  EducationalInfo(controller,slideIndex),
                  WorkInfo(controller,slideIndex),
                  Skills(controller,slideIndex),
                  MentorPersnalIInfo(controller,slideIndex),
                  UplodCv(controller,slideIndex),
                  MentorEducationInfo(controller,slideIndex),
                  MentorWorkInfo(controller,slideIndex),
                  QuickApplication(controller,slideIndex),
                  MenteeProfileOverView(controller,slideIndex),
                  MentorProfileOverView(controller,slideIndex),

                ],
              ),
            )
      ),
    );
  }
}
