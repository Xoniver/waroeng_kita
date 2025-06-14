import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constant.dart';
import '../../controllers/scale_factor_controller.dart';
import '../home/widgets/home_header_widget.dart';
import '../home/widgets/home_list_product_widget.dart';

class CariProdukView extends StatefulWidget {
  const CariProdukView({super.key});

  @override
  State<CariProdukView> createState() => _CariProdukViewState();
}

class _CariProdukViewState extends State<CariProdukView> {
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
              Padding(padding: EdgeInsets.only(top: 12,  left: 12, right: 12), child:
              Text(
                'Pencarian Produk',
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