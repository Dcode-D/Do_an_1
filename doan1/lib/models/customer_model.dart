class Customer{
  String id;
  String avatar;
  String name;
  String email;
  String phone;
  String address;
  String iDCard;
  String idBankAccount;

  Customer({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.iDCard,
    required this.idBankAccount
  });
}

// Note: This is a dummy data for testing purpose
List<Customer> customers = [
  Customer(
    id: '1',
    avatar: 'assets/images/avatar0.jpg',
    name: 'Customer 0',
    email: '',
    phone: '',
    address: '',
    iDCard: '',
    idBankAccount: ''),
  Customer(
      id: '2',
      avatar: 'assets/images/avatar0.jpg',
      name: 'Customer 0',
      email: '',
      phone: '',
      address: '',
      iDCard: '',
      idBankAccount: ''),
  Customer(
      id: '3',
      avatar: 'assets/images/avatar0.jpg',
      name: 'Customer 0',
      email: '',
      phone: '',
      address: '',
      iDCard: '',
      idBankAccount: ''),
  Customer(
      id: '4',
      avatar: 'assets/images/avatar0.jpg',
      name: 'Customer 0',
      email: '',
      phone: '',
      address: '',
      iDCard: '',
      idBankAccount: ''),
];