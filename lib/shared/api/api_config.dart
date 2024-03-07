class Config {
  //Auth
  static String loginEndpoints = '/v1/auth/driver/login';
  static String logutEndpoints = '/v1/auth/driver/logout';
  static String refreshEndpoints = '/v1/auth/driver/refresh';
  //User
  static String registerEndpoints = '/v1/drivers/profile';
  static String updateFcm = '/v1/drivers/fcm';
  static String updateLanguage = '/v1/users/language';
  //Listing
  //KYC
  static String submitPersonal = "/v1/kyc/submit-personal";
  static String submitVehicle = "/v1/kyc/submit-vehicle";
  static String fetchListingEndpoint = '/v1/listing/';
  static String fetchListingByIdEndpoint = '/v1/listing/';
  static String postListingEndpoint = '/v1/listing/';
  static String putListingEndpoint = '/v1/listing/';
  static String renewListingEndpoint = '/v1/listing/renew/';
  //Material
  static String fetchMaterialsEndpoint = '/v1/material/';
  //Notification
  static String fetchNotificationsEndpoint = '/v1/notification/';
  //Bid
  static String fetchBidsEndpoint = '/v1/bid/';
  static String fetchAcceptedBidEndpoint = '/v1/bid/accepted/';
  static String createBidEndpoint = '/v1/bid/';
  static String acceptBidEndpoint = '/v1/bid/accept/';
  static String rejectBidEndpoint = '/v1/bid/reject/';
  //Order
  static String fetchOrderEndpoint = '/v1/order/';
  //Address
  static String getAddresses = '/v1/address/';
  static String addAddresses = '/v1/address/';
  static String getCity = '/v1/address/city/';
  static String getClosestCity = "/v1/address/city/closest/";
  static String addDefaultAddress = "/v1/users/defaultaddress/";

  //Payment
  static String checkPaymemntStatus = '/v1/payment/checkstatus/';
  static String createPayment = '/v1/payment/';
  static String hasNoPendingpayment = '/v1/payment/hasnopendingpayment/';
}
