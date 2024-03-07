export './assets.dart';
export './dimensions.dart';
export './font_family.dart';
export './string.dart';
export 'color.dart';

List<Map<String, String>> vehicleSelector = [
  {'key': 'bike', 'label': 'Bike', 'img': 'assets/images/bike.png'},
  {'key': 'auto', 'label': 'Auto', 'img': 'assets/images/tuktuk.png'},
  {'key': 'hatchback', 'label': 'Hatchback', 'img': 'assets/images/car.png'},
  {'key': 'sedan', 'label': 'Sedan', 'img': 'assets/images/car.png'},
  {'key': 'suv', 'label': 'SUV', 'img': 'assets/images/car.png'},
];
List vehicles = [
  {
    'id': 0,
    'name': 'Bike',
    'seater': '1 seater',
    'price': '₹ 70',
    'img': 'assets/images/bike.png'
  },
  {
    'id': 1,
    'name': 'Auto',
    'seater': '3 seater',
    'price': '₹ 100',
    'img': 'assets/images/tuktuk.png'
  },
  {
    'id': 2,
    'name': 'Car',
    'seater': '4 seater',
    'price': '₹ 200',
    'img': 'assets/images/car.png'
  },
];

List paymentmethods = [
  {'id': 0, 'paythrough': 'Cash', 'img': 'assets/images/cash.png'},
  {'id': 1, 'paythrough': 'Paytm', 'img': 'assets/images/paytm.png'},
  {'id': 2, 'paythrough': 'PhonePe', 'img': 'assets/images/phonepe.png'},
  {'id': 3, 'paythrough': 'GPay', 'img': 'assets/images/gpay.png'},
  {'id': 4, 'paythrough': 'Other UPIs', 'img': 'assets/images/otherupi.png'}
];
