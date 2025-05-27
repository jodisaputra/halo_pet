import 'package:flutter/material.dart';
import 'package:halo_pet/pages/sub_pages/hospital_page.dart';
import 'package:halo_pet/pages/sub_pages/shop_page.dart';

class MedicineTabView extends StatelessWidget {
  final bool isSubPage;
  const MedicineTabView({super.key, this.isSubPage = false});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: isSubPage,
          leading: isSubPage ? const BackButton() : null,
          title: const Text('Medicines', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: isSubPage
              ? null
              : const TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: 'Hospital'),
                    Tab(text: 'Health Shop'),
                  ],
                ),
        ),
        body: isSubPage
            ? const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HospitalPage(isSubPage: true),
                  ShopPage(isSubPage: true),
                ],
              )
            : const TabBarView(
                children: [
                  HospitalPage(isSubPage: false),
                  ShopPage(isSubPage: false),
                ],
              ),
      ),
    );
  }
}