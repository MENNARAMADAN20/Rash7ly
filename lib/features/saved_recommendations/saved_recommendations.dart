import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/saved_recomm/saved_service.dart';
import 'package:rash7ly/features/home/widgets/arrow_back_app_bar.dart';

class SavedRecommendationsScreen extends StatelessWidget {
  const SavedRecommendationsScreen({super.key});

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
                  leading: Image.asset(item.image, width: 60),
                  title: Text(item.name),
                  subtitle: Text("${item.city} • ${item.category}"),
                  trailing: Text("⭐ ${item.rate}"),
                );
              },
            ),
    );
  }
}
