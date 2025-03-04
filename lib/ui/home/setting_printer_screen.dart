import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/ui/home/model/printer_model.dart';
import 'package:ticketing_apps/ui/widgets/menu_printer_button.dart';
import 'package:ticketing_apps/ui/widgets/menu_printer_content.dart';

class SettingPrinterScreen extends StatefulWidget {
  const SettingPrinterScreen({super.key});

  @override
  State<SettingPrinterScreen> createState() => _SettingPrinterScreenState();
}

class _SettingPrinterScreenState extends State<SettingPrinterScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Printer'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Container(
            width: context.deviceWidth / 2,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuPrinterButton(
                  label: 'Search',
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  isActive: selectedIndex == 0,
                ),
                MenuPrinterButton(
                  label: 'Disconnect',
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  isActive: selectedIndex == 1,
                ),
                MenuPrinterButton(
                  label: 'Test',
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  isActive: selectedIndex == 2,
                ),
              ],
            ),
          ),
          SpaceHeight(34),
          if (printers.isEmpty)
            Text('No data available')
          else if (selectedIndex == 0)
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: AppColors.black.withOpacity(5 / 100),
                    blurRadius: 30,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MenuPrinterContent(data: printers[index]);
                },
                separatorBuilder: (context, index) => SpaceHeight(16),
                itemCount: printers.length,
              ),
            )
          else if (selectedIndex == 1)
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: AppColors.black.withOpacity(5 / 100),
                    blurRadius: 30,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MenuPrinterContent(data: printers[index]);
                },
                separatorBuilder: (context, index) => SpaceHeight(16),
                itemCount: printers.length,
              ),
            )
          else if (selectedIndex == 2)
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: AppColors.black.withOpacity(5 / 100),
                    blurRadius: 30,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MenuPrinterContent(data: printers[index]);
                },
                separatorBuilder: (context, index) => SpaceHeight(16),
                itemCount: printers.length,
              ),
            ),
        ],
      ),
    );
  }
}
