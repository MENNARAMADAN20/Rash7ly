import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';
import 'package:rash7ly/features/home/data/model/review.dart';
import 'package:rash7ly/features/home/data/model/saved_recomm/saved_service.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CardDetails extends StatefulWidget {
  final PlaceModel card;
  // final String tag;

  const CardDetails({super.key, required this.card});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final reviews = ReviewService.getReviews(widget.card.title ?? "unKnown");

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: MainButton(
            text: 'Show on map',
            onPressed: () {
              //مش عارفه اعملها بقي
              MapsLauncher.launchQuery(widget.card.location ?? 'Unknown');
            },
          ),
        ),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: SizedBox(
              height: height * 0.48,
              width: double.infinity,
              child: Stack(
                children: [
                  // Hero(
                  //   tag: widget.tag,
                  //   child: Image.asset(
                  //     widget.card.image,
                  //     fit: BoxFit.cover,
                  //     height: double.infinity,
                  //     width: double.infinity,
                  //   ),
                  // ),
                  widget.card.gallery != null && widget.card.gallery!.isNotEmpty
                      ? Image.network(
                          widget.card.gallery![0],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        )
                      : Image.asset(
                          AppAssets.error,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black38,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black38,
                            child: IconButton(
                              icon: Icon(
                                SavedService.isSaved(widget.card)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                SavedService.toggleSaved(widget.card);
                                setState(() {});
                                _showSavedDialog();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.card.title ?? 'Unknown Title',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.card.rating?.toStringAsFixed(1) ?? '0.0',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.card.location ?? 'Unknown Location',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            Icons.category_outlined,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.card.category ?? 'Unknown Category',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'This destination is one of the top recommended places...',
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 85,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.card.gallery?.length ?? 0,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.card.gallery!.isNotEmpty
                                ? widget.card.gallery![index]
                                : '',
                            width: 110,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "Facilities",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        FacilityIcon(icon: Icons.wifi, title: "Wi-Fi"),
                        FacilityIcon(
                          icon: Icons.local_parking,
                          title: "Parking",
                        ),
                        FacilityIcon(
                          icon: Icons.restaurant,
                          title: "Restaurant",
                        ),
                        FacilityIcon(icon: Icons.pool, title: "Pool"),
                      ],
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ReviewTile(
                      user: "Sayed Abdul_Aziz",
                      text: "Amazing place! Totally worth visiting.",
                    ),
                    const SizedBox(height: 10),
                    ReviewTile(
                      user: "Ali",
                      text: "Great vibes and beautiful view 💙",
                    ),
                    Gap(10),
                    Column(
                      children: reviews
                          .map(
                            (r) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ReviewTile(
                                user: r["user"]!,
                                text: r["text"]!,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          ReviewService.addReview(
                            widget.card.title ?? 'Unknown Title',
                            "You",
                            commentController.text,
                          );
                          commentController.clear();
                          setState(() {});
                        }
                      },
                      child: const Text(
                        "Add Review",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSavedDialog() {
    final isSaved = SavedService.isSaved(widget.card);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Container(
          height: 70,
          margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              isSaved
                  ? "${widget.card.title ?? 'Unknown Title'} saved!"
                  : "${widget.card.title ?? 'Unknown Title'} removed!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

class FacilityIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const FacilityIcon({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue, size: 26),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String user;
  final String text;

  const ReviewTile({super.key, required this.user, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppAssets.circleAvatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$user: $text",
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
