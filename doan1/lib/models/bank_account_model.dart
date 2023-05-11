class BankAccount{
  String id;
  String name;
  String accountNumber;
  String bankNumber;
  String bankName;
  String accountType;
  String expiryDate;
  String createdAt;
  String updatedAt;

  BankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankNumber,
    required this.bankName,
    required this.accountType,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });
}

// Note: This is a dummy data for testing purpose
List<BankAccount> BankAccounts = [
  BankAccount(
      id: 'bank1',
      name: 'Tran Huu Tri',
      accountNumber: '15689456285',
      bankName: 'Vietcombank',
      bankNumber: '1234568978979795',
      accountType: 'Visa',
      expiryDate: '12/2022',
      createdAt: '15/1/2023 12:00:00',
      updatedAt: '15/1/2023 15:23:00'),
  BankAccount(
      id: 'bank2',
      name: 'Tran Huu Tri',
      accountNumber: '15689456285',
      bankName: 'Techcombank',
      bankNumber: '1234568978979795',
      accountType: 'Visa',
      expiryDate: '12/2024',
      createdAt: '15/1/2023 12:00:00',
      updatedAt: '15/1/2023 15:23:00'),
  BankAccount(
      id: 'bank3',
      name: 'Tran Huu Tri',
      accountNumber: '15689456285',
      bankName: 'Agribank',
      bankNumber: '1234568978979795',
      accountType: 'Visa',
      expiryDate: '12/2023',
      createdAt: '15/1/2023 12:00:00',
      updatedAt: '15/1/2023 15:23:00'),
];