import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/repo/home_repo.dart';
import 'package:rash7ly/features/home/widgets/arrow_back_app_bar.dart';
import 'package:rash7ly/features/home/widgets/search_bar_widget.dart';
import 'package:rash7ly/features/home/widgets/search_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  bool isloading = false;
  bool isimpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(authRepo: AuthRepository(), homeRepo: HomeRepo())
            ..add(GetAllPlacesEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leadingWidth: 60,
          leading: ArrowBackAppBar(
            backgroundColor: AppColors.lightGreyColor,
            iconColor: AppColors.darkModeColor,
          ),
          title: Text(
            "Explore",
            style: TextStyles.getSize18(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            var cubit = context.read<HomeBloc>();
            if (state is GetAllPlacesLoadingState) {
              isloading = true;
            } else if (state is GetAllPlacesSuccessState) {
              isloading = false;
              if (cubit.places == null || cubit.places!.isEmpty) {
                isimpty = true;
              }
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeBloc>();
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SearchBarWidget(
                        onSearch: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),
                    ),
                    Gap(10),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                'Explore Places',
                                style: TextStyles.getSize20(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 600,
                            child: SearchGridView(
                              searchText: searchText,
                              places: cubit.places,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
