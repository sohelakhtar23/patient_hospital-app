import 'package:flutter/material.dart';
import 'package:hospital_ui/constants.dart';
import 'package:hospital_ui/models/sign_out.dart';

import 'package:hospital_ui/screens/appointment.dart';
import 'package:hospital_ui/screens/doctor_page.dart';
import 'package:hospital_ui/screens/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:badges/badges.dart';
import 'package:hospital_ui/data/json.dart';
import 'package:hospital_ui/widgets/textbox.dart';
import 'package:hospital_ui/widgets/popular_doctor.dart';
import 'package:hospital_ui/widgets/category_box.dart';





class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [HomePage(), DoctorPage(),  AppointmentPage(), ProfilePage()];

  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _pages
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: kPrimary,
            inactiveColor: Colors.black,
            title: Text('Home'),
            icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
            activeColor: kPrimary,
            inactiveColor: Colors.black,
            title: Text('Doctors'),
            icon: Icon(Icons.medical_services_rounded)
          ),
          
          BottomNavyBarItem(
            activeColor: kPrimary,
            inactiveColor: Colors.black,
            title: Text('Appointment'),
            icon: Icon(Icons.event_note_rounded)
          ),
          BottomNavyBarItem(
            activeColor: kPrimary,
            inactiveColor: Colors.black,
            title: Text('Profile'),
            icon: Icon(Icons.manage_accounts_rounded)
          ),
        ],
      ),
    );
  }

}


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  String username='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initial();
  }

  // void initial() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString('username') ?? 'User';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          SignOut(),
          SizedBox(width: 20),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Badge(
              position: BadgePosition.topEnd(top: 7, end: -4),
              badgeContent: Text('1', style: TextStyle(color: Colors.white),),
              child: Icon(Icons.notifications_sharp, color: kPrimary,),
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  getBody(){
    return
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(child: Text("Hi,", style: TextStyle(fontSize: 23, color: kPrimary, fontWeight: FontWeight.w500),),),
                    Text('User'),
                  ],
                ),
                SizedBox(height: 5,),
                Container(child: Text("Let's Find Your Doctor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                SizedBox(height: 15,),
                CustomTextBox(),
                SizedBox(height: 25,),
                Container(child: Text("Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                SizedBox(height:10),
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 5),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryBox(title: "Heart", icon: Icons.favorite, color: Colors.red, ),
                      CategoryBox(title: "Medical", icon: Icons.local_hospital, color: Colors.blue, ),
                      CategoryBox(title: "Dental", icon: Icons.details_rounded, color: Colors.purple, ),
                      CategoryBox(title: "Healing", icon: Icons.healing_outlined, color: Colors.green, ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage("https://media.istockphoto.com/vectors/electronic-health-record-concept-vector-id1299616187?k=20&m=1299616187&s=612x612&w=0&h=gmUf6TXc8w6NynKB_4p2TzL5PVIztg9UK6TOoY5ckMM="), 
                      fit: BoxFit.cover,)
                  ),
                ),
                SizedBox(height: 25,),
                Container(child: Text("Popular Doctors", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                SizedBox(height: 10),
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 5),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PopularDoctor(doctor: doctors[0],),
                      PopularDoctor(doctor: doctors[1],),
                      PopularDoctor(doctor: doctors[2],),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              ]
          ),
        ),
      );
  }
}
