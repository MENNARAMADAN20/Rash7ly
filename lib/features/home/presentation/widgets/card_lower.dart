import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/features/home/presentation/card_imags/card_images.dart';

class CardLower extends StatelessWidget {
  const CardLower({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommend name",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Category name",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(AppAssets.circleAvatar),
                    ),
                    Gap(5),
                    Text('name'),
                  ],
                ),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 18),
                    SizedBox(width: 4),
                    Text("City", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text("4.7 (2498)"), //rate and number of people who rated
                  ],
                ),
                Text(
                  "\$59/Person",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Gap(20),
            SizedBox(
              height: 50,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if (index < 10) {
                    return GestureDetector(
                      onTap: () {
                        openImageViewer(context, index, images);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          images[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        // show more photos
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              _buildMoreImagesSheet(context, images),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                itemCount: images.length + 1,
                separatorBuilder: (context, index) => const Gap(10),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Gap(20),
            Text(
              'About Destination',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gap(6),
            const Text(
              "You will get a complete travel package on the beaches. Packages in the form of airline tickets, hotel rooms, etc... ",
              style: TextStyle(color: AppColors.greyColor, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMoreImagesSheet(BuildContext context, Images) {
  return Container(
    padding: const EdgeInsets.all(16),
    height: 300,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: Images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(Images[index], fit: BoxFit.cover),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              Images[index],
              //  'assets/images/more_${index + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}

void openImageViewer(
  BuildContext context,
  int initialIndex,
  List<String> images,
) {
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) {
      PageController controller = PageController(initialPage: initialIndex);

      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: controller,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    child: Image.asset(images[index], fit: BoxFit.contain),
                  );
                },
              ),

              Positioned(
                top: 40,
                right: 20,
                child: Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ],
          ),
        ),
      );
    },
  );
}
