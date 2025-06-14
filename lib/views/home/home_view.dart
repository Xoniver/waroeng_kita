import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/home/widgets/home_carousel_widget.dart';
import 'package:waroeng_kita/views/home/widgets/home_header_widget.dart';
import 'package:waroeng_kita/views/home/widgets/home_list_product_widget.dart';
import 'package:waroeng_kita/views/home/widgets/home_menu_widget.dart';

import '../../constants/color_constant.dart';
import '../../controllers/scale_factor_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              HomeCarouselWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              HomeMenuWidget(),
              Padding(padding: EdgeInsets.only(top: 12,  left: 12, right: 12), child:
              Text(
                'Produk Terbaik BUMDes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),),

              HomeProductWidget()
            ],
          ),
        ),
      ),
    );
  }
}