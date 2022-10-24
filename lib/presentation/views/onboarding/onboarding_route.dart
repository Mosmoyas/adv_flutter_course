// ignore_for_file: unused_element

import 'package:adv_flutter_course/presentation/resources/assets_manager.dart';
import 'package:adv_flutter_course/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  late final List<SliderObject> _list = _getSliderData();
  List<SliderObject> _getSliderData() => [
        SliderObject(StringManager.onBoardingTitle1,
            StringManager.onBoardingTitle1, ImageAssets.onBoardingsLogo_1),
        SliderObject(StringManager.onBoardingTitle4,
            StringManager.onBoardingTitle2, ImageAssets.onBoardingsLogo_2),
        SliderObject(StringManager.onBoardingTitle3,
            StringManager.onBoardingTitle3, ImageAssets.onBoardingsLogo_3),
        SliderObject(StringManager.onBoardingTitle2,
            StringManager.onBoardingTitle4, ImageAssets.onBoardingsLogo_4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark),
      ),
      backgroundColor: ColorManager.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingsPage(
            sliderObject: _list[index],
          );
        },
      ),
      bottomSheet: Container(
          color: ColorManager.white,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.logingRoute);
                  },
                  child: Text(StringManager.skip,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleMedium)),
            ),
            _getBottomSheetItems()
          ])),
    );
  }

  Widget _getBottomSheetItems() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //left arrow

          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_getPreviousIndex(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          //circle indicators
          Row(
            children: [
              for (int i = 0; i < _list.length; i++)
                currentIndex == i
                    ? Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: SvgPicture.asset(ImageAssets.hollowCircleIc),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: SvgPicture.asset(ImageAssets.solidCircleIc),
                      )
            ],
          ),
          //right arrow

          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_getNextIndex(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getPreviousIndex() {
    int previousIndex = --currentIndex;
    if (previousIndex == -1) previousIndex = _list.length - 1;
    return previousIndex;
  }

  int _getNextIndex() {
    int nextIndex = ++currentIndex;
    if (nextIndex == _list.length) nextIndex = _list.length - 1;
    return nextIndex;
  }

  _arrowIcon(String icon, Function func) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p14),
      child: GestureDetector(
        //go to next/previous slide
        onTap: func(),
        child: SizedBox(
          height: AppSize.s20,
          width: AppSize.s20,
          child: SvgPicture.asset(icon),
        ),
      ),
    );
  }
}

class OnBoardingsPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingsPage({super.key, required this.sliderObject});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderObject.image)
      ],
    );
  }
}

class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}
