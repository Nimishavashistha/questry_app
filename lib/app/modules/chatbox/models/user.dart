class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Nimisha Kumari',
  imageUrl: 'assets/avatars/u15.jpg',
  isOnline: true,
);

final User SimranBhogal = User(
  id: 1,
  name: 'Simran Bhogal',
  imageUrl: 'assets/avatars/u14.jpg',
  isOnline: true,
);

final User MuskanRoy = User(
  id: 2,
  name: 'Muskan Roy',
  imageUrl: 'assets/avatars/u6.jpg',
  isOnline: true,
);

final User NishaRoy = User(
  id: 3,
  name: 'Nisha Roy',
  imageUrl: 'assets/avatars/u10.jpg',
  isOnline: false,
);

final User AnupKumar = User(
  id: 4,
  name: 'Anup Kumar',
  imageUrl: 'assets/avatars/u7.jpg',
  isOnline: false,
);

final User KabirPiplani = User(
  id: 5,
  name: 'Kabir Piplani',
  imageUrl: 'assets/avatars/u5.jpg',
  isOnline: false,
);
