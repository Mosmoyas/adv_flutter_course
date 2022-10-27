abstract class BaseViewModel extends BaseViewModelInPuts
    with BaseViewModelOutPuts {
  //shared variables and functions that will be used through out any view model
}

abstract class BaseViewModelInPuts {
  void start(); // start view model job
  void dispose(); // will be called when view model dies
}

abstract class BaseViewModelOutPuts {}
