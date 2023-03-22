import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/homepage_controller.dart';

import 'welcome.dart';
import 'test.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final homepagecontroller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final developers = {
      'Riceneeder': 'riceneeder',
    };
    return Obx(() => AdwScaffold(
          flapController: homepagecontroller.flapController.value,
          actions: AdwActions().bitsdojo,
          start: [
            AdwHeaderButton(
              icon: const Icon(
                Icons.view_sidebar_outlined,
                size: 19,
              ),
              isActive: homepagecontroller.flapController.value.isOpen,
              onPressed: homepagecontroller.toggleFlapController,
            )
          ],
          end: [
            GtkPopupMenu(
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AdwButton.flat(
                    padding: AdwButton.defaultButtonPadding.copyWith(
                      top: 10,
                      bottom: 10,
                    ),
                    child: const Text(
                      '按钮1',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const Divider(),
                  AdwButton.flat(
                    padding: AdwButton.defaultButtonPadding.copyWith(
                      top: 10,
                      bottom: 10,
                    ),
                    child: const Text(
                      '按钮2',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  AdwButton.flat(
                    padding: AdwButton.defaultButtonPadding.copyWith(
                      top: 10,
                      bottom: 10,
                    ),
                    onPressed: () => showDialog<Widget>(
                      context: context,
                      builder: (ctx) => AdwAboutWindow(
                        issueTrackerLink: 'https://github.com/riceneeder',
                        appIcon: SvgPicture.asset(
                          'asset/yoyoos_logo.svg',
                          height: 100,
                        ),
                        actions: AdwActions(
                          onClose: Navigator.of(context).pop,
                          onHeaderDrag: appWindow?.startDragging,
                          onDoubleTap: appWindow?.maximizeOrRestore,
                        ),
                        credits: [
                          AdwPreferencesGroup.credits(
                            title: 'Developers',
                            children: developers.entries
                                .map(
                                  (e) => AdwActionRow(
                                    title: e.key,
                                    onActivated: () => launchUrl(
                                      Uri.parse(
                                          'https://github.com/${e.value}'),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        copyright: 'Copyright 2021-2022',
                        license: const Text(
                          'GNU LGPL-3.0, This program comes with no warranty.',
                        ),
                      ),
                    ),
                    child: const Text(
                      '关于',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            AdwWindowButton(
                buttonType: WindowButtonType.minimize,
                onPressed: appWindow?.minimize),
          ],
          flap: (isDrawer) => AdwSidebar(
            currentIndex: homepagecontroller.currentIndex.value,
            isDrawer: isDrawer,
            children: const [
              AdwSidebarItem(
                label: 'Welcome',
              ),
              AdwSidebarItem(
                label: 'Test',
              )
            ],
            onSelected: homepagecontroller.changeCurrentIndex,
          ),
          title: const Text('初始模板'),
          body: AdwViewStack(
            animationDuration: const Duration(milliseconds: 600),
            index: homepagecontroller.currentIndex.value,
            children: const [Welcome(), Test()],
          ),
        ));
  }
}
