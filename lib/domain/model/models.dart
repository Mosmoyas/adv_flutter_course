//Create Object SliderObject to be added to the List _gestSliderData
class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}

//SliderViewObject to carry the data come from the ViewModel to the View
class SliderViewObject {
  SliderObject sliderObject; //Object as an List Item
  int nunOfSlider;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.nunOfSlider);
}
// class non nullable values because we will use  NonNull extentions class instead for primitives data types
class Customer {
  String id;
  String name;
  int nunOfNotifications;

  Customer(this.id, this.name, this.nunOfNotifications);
}

class Contacts {
  String name;
  String email;
  String link;
  Contacts(this.name, this.email, this.link);
}

// we used here null checkable ? beacuse the Objects Customers and Contacts are not premitiv classes
class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}
