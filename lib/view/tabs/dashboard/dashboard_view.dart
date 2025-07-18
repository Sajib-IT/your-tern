import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/view/tabs/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController _controller = Get.put(DashboardController());
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      _controller.currentIndex.value = index;
                    },
                  ),
                  items:
                      _controller.carouselItems.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    item["image"]!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    // loadingBuilder: (context, child, progress) {
                                    //   if (progress == null) return child;
                                    //   return Center(child: CircularProgressIndicator());
                                    // },
                                    errorBuilder:
                                        (_, __, ___) => const Center(
                                          child: Text("Image not available"),
                                        ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item["text"] ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'NotoSansBengali',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                ),

                SizedBox(height: 8),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _controller.carouselItems.length,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _controller.currentIndex.value == index
                                  ? Colors.blueAccent
                                  : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            // Text(
            //   "Your Running Task: ",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // ..._controller.groupNames.map(
            //   (item) => Text(
            //     "Group name : $item",
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            //   ),
            // ),
            runningTasks(_controller.groupNames)
          ],
        ),
      ),
    );
  }
  
  Widget runningTasks(List<String> groupNames) {
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Running Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 12),
            ...groupNames.map(
                  (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.group, size: 20, color: Colors.teal),
                    const SizedBox(width: 8),
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
