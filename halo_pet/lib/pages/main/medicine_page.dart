import 'package:flutter/material.dart';
import 'package:halo_pet/pages/sub_pages/hospital_page.dart';
import 'package:halo_pet/pages/sub_pages/shop_page.dart';

class MedicineTabView extends StatelessWidget {
  const MedicineTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text('Medicines', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Hospital'),
              Tab(text: 'Health Shop'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HospitalPage(),
            ShopPage(),
          ],
        ),
      ),
    );
  }
}