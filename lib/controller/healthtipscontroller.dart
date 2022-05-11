import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_preview_generator/link_preview_generator.dart' as lp;

import 'package:period_tracker/model/healthtipsmodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class HealtTipsController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    fetchHealthTips();
  }

  List<HealthTipsModel> healthTips = <HealthTipsModel>[];

  fetchHealthTips() async {
    loading = true;
    update();
    var response = await RemoteServices.readHealthTips();
    healthTips = healthTipsModelFromJson(response);
    getWidgets();
    loading = false;
    update();
  }

  uploadHealthTips(HealthTipsModel model) async {
    loading = true;
    update();
    var response = await RemoteServices.uploadHealthTips(model);
    loading = false;
    update();
  }

  List<Widget> getWidgets() {
    List<Widget> news = [];
    for (var item in healthTips) {
      news.add(
        lp.LinkPreviewGenerator(
          bodyMaxLines: 2,
          link: item.url,
          linkPreviewStyle: lp.LinkPreviewStyle.large,
          showGraphic: true,
          backgroundColor: Colors.grey.shade300,
          removeElevation: true,
          showDomain: false,
        ),
      );
    }
    return news;
  }
}
