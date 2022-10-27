class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}

//SliderViewObject to carry the data come from the ViewModel to the View
class SliderViewObject {
  SliderObject sliderObject;
  int nunOfSlider;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.nunOfSlider);
}
