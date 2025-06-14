import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waroeng_kita/views/cari_produk/cari_produk_view.dart';
import 'package:waroeng_kita/views/profile/profile_view.dart';
import 'package:waroeng_kita/views/transaksi/transaksi_view.dart';

import '../../constants/color_constant.dart';
import '../../constants/textstyle_constant.dart';
import '../home/home_view.dart';

class NavigationBarView extends StatefulWidget {
  final int? initialIndex;
  final int? transaksiInitialTabIndex;

  const NavigationBarView({
    super.key,
    this.initialIndex,
    this.transaksiInitialTabIndex,
  });

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  late int currentPageIndex;
  late int transaksiTabIndex;

  @override
  void initState() {
    super.initState();
    // Ambil nilai dari arguments (jika ada), atau default
    currentPageIndex  = widget.initialIndex ?? 0;
    transaksiTabIndex = widget.transaksiInitialTabIndex ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        pageIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
            // Jika user tap menu Transaksi di navbar,
            // reset sub-tab ke index 1 (Transaksi)
            if (index == 2) {
              transaksiTabIndex = 1;
            }
          });
        },
      ),
      backgroundColor: Colors.white,
      body: [
        const HomeView(),
        const CariProdukView(),
        // Gunakan transaksiTabIndex yang di-manage di state
        TransaksiView(initialTabIndex: transaksiTabIndex),
        const ProfileView(),
      ][currentPageIndex],
    );
  }
}

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: Platform.isAndroid ? 0 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 30,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        elevation: 8.0,
        color: Colors.white,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navItem(
              'assets/icons/home.svg',
              pageIndex == 0,
              'Home',
              onTap: () => onTap(0),
            ),
            navItem(
              'assets/icons/cariproduk.svg',
              pageIndex == 1,
              'Cari Produk',
              onTap: () => onTap(1),
            ),
            navItem(
              'assets/icons/transaksi.svg',
              pageIndex == 2,
              'Transaksi',
              onTap: () => onTap(2),
            ),
            navItem(
              'assets/icons/profile.svg',
              pageIndex == 3,
              'Profile',
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(dynamic icon, bool selected, String label, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon is String
                ? SvgPicture.asset(
              icon,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                selected ? ColorConstant.blackColor : ColorConstant.darkColor3,
                BlendMode.srcIn,
              ),
            )
                : Icon(
              icon,
              size: 28,
              color: selected ? ColorConstant.blackColor : ColorConstant.darkColor3,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: 12,
                color: selected ? ColorConstant.blackColor : ColorConstant.darkColor3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
