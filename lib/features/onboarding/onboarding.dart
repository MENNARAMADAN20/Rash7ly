import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/onboarding/model/onboardModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardModel> pages = [
    OnboardModel(
      image: 'assets/images/onboarding1.png',
      title: 'Get the Best\nRecommendations',
      description:
          'Not sure what to choose?\nRasha7ly helps you find trusted suggestions from outings and hotels to electronics and more',
      buttonText: 'Get Started',
    ),
    OnboardModel(
      image: 'assets/images/onboarding2.png',
      title: "It's a big world of\nchoices out there",
      description:
          'Choose what you need, and discover trusted recommendations.\nWe are here for you!',
      buttonText: 'Next',
    ),
    OnboardModel(
      image: 'assets/images/onboarding3.png',
      title: 'Choices shape people',
      description:
          'Just open Rasha7ly and explore trusted recommendations.\nWe are waiting for you!',
      buttonText: 'Next',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(page.image, fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    page.title,
                    textAlign: TextAlign.center,
                    style: TextStyles.getSize30(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    page.description,
                    textAlign: TextAlign.center,
                    style: TextStyles.getSize12(
                      color: Color(0xff7D848D),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: const Color(0xff0D6EFD),
                      dotColor: Colors.grey.shade300,
                      dotHeight: 8,
                      dotWidth: 16,
                      expansionFactor: 3,
                      spacing: 5,
                    ),
                  ),

                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0D6EFD),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          context.go('/signIn');
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        page.buttonText,
                        style: TextStyles.getSize16(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              );
            },
          ),
          Positioned(
            top: 40,
            right: 10,
            child: TextButton(
              onPressed: () {
                context.go('/signIn');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
