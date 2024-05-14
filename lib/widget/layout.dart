// ignore_for_file: unused_local_variable

import 'package:chat/screen/home/chat_home_screen.dart';
import 'package:chat/screen/home/group_home_screen.dart';
import 'package:chat/screen/home/contact_screen.dart';
import 'package:chat/screen/home/setting_home_sreen.dart';
import 'package:flutter/material.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({super.key});

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

class _LayoutAppState extends State<LayoutApp> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
Widget build(BuildContext context) {
  List<Widget>screen = [];
  return Scaffold(
    body: PageView(
      onPageChanged:(value){
        setState(() {
          currentIndex = value ;
        });
      } ,
      controller:pageController ,
      children: const [
      ChatHomeScreen(),GroupHomeScreen(),ContactScreen(),SettingScreen(),
      ],


    ),
    bottomNavigationBar: NavigationBar(
      //  elevation:10,
      selectedIndex: currentIndex,
      onDestinationSelected: (value){
        setState(() {
          currentIndex = value;
          pageController.jumpToPage(value);
          
        });
      },
      destinations: const [
       
       
        NavigationDestination(
          icon: Icon(Icons.chat),
          label: "chat",
        ),
          NavigationDestination(
           icon: Icon(Icons.group),
          label: "group",
        ),
             NavigationDestination(
          icon: Icon(Icons.contact_mail),
          label: "contact",
        ),
          NavigationDestination(
          icon: Icon(Icons.settings),
          label: "setting",
        ),
      ],
    ),
  );
}}