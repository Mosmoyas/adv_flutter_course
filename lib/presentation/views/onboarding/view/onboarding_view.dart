// ignore_for_file: unused_element

import 'package:adv_flutter_course/presentation/resources/assets_manager.dart';
import 'package:adv_flutter_course/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../dmain/models.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../view_model/onboarding_view_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.OutPutSliderViewObject,
      builder: (context, snapShot) {
        return _getContentWidget(snapShot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) return Container();
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
        itemCount: sliderViewObject.nunOfSlider,
        onPageChanged: (index) {
          _viewModel.onPageChange(index);
        },
        itemBuilder: (context, index) {
          return OnBoardingsPage(
            sliderObject: sliderViewObject.sliderObject,
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
            _getBottomSheetItems(sliderViewObject)
          ])),
    );
  }

  Widget _getBottomSheetItems(SliderViewObject sliderViewObject) {
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
                _pageController.animateToPage(_viewModel.goPrevious(),
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
              for (int i = 0; i < sliderViewObject.nunOfSlider; i++)
                _viewModel.currentIndex == i
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
                _pageController.animateToPage(_viewModel.goNext(),
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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
