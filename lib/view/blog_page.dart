import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:get/get.dart';
import 'package:link_preview_generator/link_preview_generator.dart' as lp;
import 'package:period_tracker/controller/healthtipscontroller.dart';
import 'package:period_tracker/model/healthtipsmodel.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff072227),
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<HealtTipsController>(
          init: HealtTipsController(),
          builder: (controller) {
            return controller.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 30),
                      cs.CarouselSlider(
                        options: cs.CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          height: MediaQuery.of(context).size.height * 0.25,
                          enlargeCenterPage: true,
                        ),
                        items: controller.getWidgets(),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.healthTips.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: lp.LinkPreviewGenerator(
                                bodyMaxLines: 4,
                                link: controller.healthTips[index].url,
                                linkPreviewStyle: lp.LinkPreviewStyle.small,
                                showGraphic: true,
                                backgroundColor: Colors.grey.shade300,
                                removeElevation: true,
                                showDomain: false,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
          }),
    );
  }
}

class CarouselSlider {}

class LinkPreviewGenerator {}
