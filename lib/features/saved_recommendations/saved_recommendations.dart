import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/data/model/saved_recomm/saved_service.dart';
import 'package:rash7ly/features/home/widgets/arrow_back_app_bar.dart';

class SavedRecommendationsScreen extends StatefulWidget {
  const SavedRecommendationsScreen({super.key});

  @override
  State<SavedRecommendationsScreen> createState() =>
      _SavedRecommendationsScreenState();
}

class _SavedRecommendationsScreenState
    extends State<SavedRecommendationsScreen> {
  @override
  Widget build(BuildContext context) {
    final saved = SavedService.saved;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 60,
        title: Text(
          'Saved Recommendations',
          style: TextStyles.getSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: ArrowBackAppBar(
          backgroundColor: AppColors.lightGreyColor,
          iconColor: AppColors.blueColor,
        ),
      ),

      body: saved.isEmpty
          ? const Center(child: Text("No saved items yet"))
          : ListView.builder(
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final item = saved[index];

                return ListTile(
                  leading: Image.network(
                    item.gallery!.isNotEmpty ? item.gallery![0] : '',
                    width: 60,
                  ),
                  title: Text(item.title ?? 'No Title'),
                  subtitle: Text("${item.location} • ${item.category}"),
                  trailing: Text(
                    "⭐ ${item.rating?.toStringAsFixed(1) ?? '0.0'}",
                  ),
                );
              },
            ),
    );
  }
}
