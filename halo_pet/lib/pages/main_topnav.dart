import 'package:flutter/material.dart';
import 'package:halo_pet/pages/sub_pages/hospital_page.dart';
import 'package:halo_pet/pages/sub_pages/shop_page.dart';

class MainTopnav extends StatelessWidget {
  const MainTopnav({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopNavBar(),
    );
  }
}

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Hospital',
              ),
              Tab(
                text: 'Health Store',
              )
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            HospitalPage(),
            ShopPage()
          ]
        ),
      )
    );
  }
}