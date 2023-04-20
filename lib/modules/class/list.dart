import 'dashBoardItem.dart';

List<DashboardItem> generateDummyData(int count) {
  List<DashboardItem> items = [];
  for (int i = 0; i < 2; i++) {
    items.add(
      DashboardItem(
        size: 100,
        date: '2023/03/01',
        time: '12:00 PM',
        address: 'Chetandra Pratap Singh',
        typeOfWash: 'Interior',
        username: 'Online',
        paymentStatus: 'Complete',
      ),
    );
  }
  for (int i = 0; i < 10; i++) {
    items.add(
      DashboardItem(
        size: 100,
        date: '2023/03/01',
        time: '01:00 PM',
        address: 'Vangipurappu',
        typeOfWash: 'Exterior',
        username: 'Debit Card',
        paymentStatus: 'Pending',
      ),
    );
  }
  items.add(
    DashboardItem(
      size: 100,
      date: '2023/03/01',
      time: '03:00 PM',
      address: 'Balakrishnan',
      typeOfWash: 'Exterior',
      username: 'Debit Card',
      paymentStatus: 'Pending',
    ),
  );
  for (int i = 0; i < 2; i++) {
    items.add(
      DashboardItem(
        size: 100,
        date: '2023/02/01',
        time: '9:00 PM',
        address: 'Address ${i + 1}',
        typeOfWash: 'Exterior',
        username: 'User ${i + 1}',
        paymentStatus: 'Pending',
      ),
    );
  }
  for (int i = 0; i < 6; i++) {
    items.add(
      DashboardItem(
        size: 100,
        date: '2023/03/02',
        time: '12:00 PM',
        address: 'Namo',
        typeOfWash: 'Exterior',
        username: 'Cash on Delivery',
        paymentStatus: 'Pending',
      ),
    );
  }
  return items;
}
