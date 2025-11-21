import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import '../../Bloc/add_rec_bloc.dart';
import '../../Data/repo/add_recommendation_repo.dart';
import '../../../../core/services/cloudinare_service/cloudinary_service.dart';
import 'add_rec_form_body.dart';

class AddNewRec extends StatelessWidget {
  const AddNewRec({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (currentIndex == 0) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (context) {
              // Dependencies injection
              final cloudSvc = CloudinaryService();
              final repo = AddRecommendationRepo(cloudinary: cloudSvc);

              return BlocProvider(
                create: (_) => AddRecBloc(repo),
                child: const AddRecFormBody(),
              );
            },
          );
        }
      },
      backgroundColor: AppColors.blueColor,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }
}
