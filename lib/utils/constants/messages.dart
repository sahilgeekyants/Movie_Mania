class ToastMessages {
  static Map<String, String> errorMessage = {
    "emptyData": "No Content Available",
    "httpError": "Some Error occured, Please try again later",
    "NoInternet": "Poor Internet detected, Please check network connection",
  };
  static Map<String, String> succesMessage = {
    "success": "Api call succeeded",
    "cloudSyncSuccess": "Upload succeeded",
    "everythingInSync": "Cloud is synced",
  };
  static Map<String, String> loadingMessages = {
    "cloudSyncLoad": "Cloud Upload in progress",
    "splashLoad": "Getting Things set up",
    "databaseLoad": "Syncing data from cloud DB....",
    "imageLoad": "Loading Image",
  };
}
