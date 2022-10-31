// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names

import 'dart:async';

import 'package:adv_flutter_course/domain/model/models.dart';
import 'package:adv_flutter_course/presentation/base/base_view_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
// import 'package:adv_flutter_course/presentation/views/onboarding/view/onboarding_route.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // Stream Controllers outputs as a final becausse it will be not changed
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentIndex = 0;

  //OnBoarding ViewModel Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //View Model Starts his Job
    _list = _getSliderData(); // intialization of _list
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++currentIndex;
    if (nextIndex == _list.length) nextIndex = _list.length - 1;
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentIndex;
    if (previousIndex == -1) previousIndex = _list.length - 1;
    return previousIndex;
  }

  @override
  void onPageChange(int index) {
    currentIndex = index; //update the current index
    _postDataToView(); //send the the new data
  }

  @override
  // to can access the sink of the stream controller
  // Sink get inputSliderViewObject => _streamController.sink;
  Sink get inPutSliderViewObject => _streamController.sink;

  @override
  //take the result from sink in a map as OutPuts and then passed to the StreamController
  Stream<SliderViewObject> get OutPutSliderViewObject =>
      _streamController.stream.map((sliderObject) => sliderObject);
//OnBoarding private functions

  void _postDataToView() {
    inPutSliderViewObject
        .add(SliderViewObject(_list[currentIndex], currentIndex, _list.length));
  }

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
}

//inputs and outputs of the OnBoardingViewModel

//inputs means that "Orders" that OnBoardingViewModel will Recive from View
abstract class OnBoardingViewModelInputs {
  void goNext(); // to get next page view
  void goPrevious(); //to get next previous view
  void onPageChange(int index); //

  //Stram Controller Input which refer to Sink
  // we created the Sink with [get] to can be overriden from OnBoardingViewModel.
  Sink get inPutSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  // we will use for the Outputs view model Stream Controller
  // we created the Stream with [get] to can be overriden from OnBoardingViewModel.
  Stream<SliderViewObject> get outPutSliderViewObject =>
      throw UnimplementedError();
}
