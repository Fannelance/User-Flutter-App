class StoreModel {
  final String name;
  final String logo;
  final String url;
  final String? cover;

  StoreModel({
    required this.name,
    required this.logo,
    required this.url,
    this.cover,
  });
}

List<StoreModel> storesList = [
  StoreModel(
    name: 'Bnaia',
    logo: 'assets/logos/bnaia.jpeg',
    url: 'https://bnaia.com/ar/total-tools-tacsd30326?gad_source=1&gclid=Cj0KCQjwsaqzBhDdARIsAK2gqnc5xr_2bpQ73K6iJeaPcXvjn6zOgeNkliRE2YBQnsqza_T_0PMvRg4aArteEALw_wcB',
    cover: 'assets/logos/tools.jpg',
  ),
  StoreModel(
    name: 'Castorama',
    logo: 'assets/logos/castorama.png',
    url: 'https://www.castorama.fr/',
    cover: 'assets/logos/tools2.jpeg',
  ),
  StoreModel(
    name: 'OBI',
    logo: 'assets/logos/obi.jpg',
    url: 'https://www.obi.de/',
  ),
  StoreModel(
    name: "Lowe's",
    logo: 'assets/logos/lowes.png',
    url: 'https://www.lowes.com/',
  ),
  StoreModel(
    name: 'Rockler',
    logo: 'assets/logos/rockler.jpeg',
    url: 'https://www.rockler.com/',
  ),
  StoreModel(
    name: 'Toom',
    logo: 'assets/logos/toom.png',
    url: 'https://toom.de/',
  ),
  StoreModel(
    name: 'Just Piece',
    logo: 'assets/logos/justPiece.jpg',
    url:
        'https://justpiece.com/en/product/multifunctional-wire-stripper-25-in-1-wire-stripper-cutter-crimper-needle-nose-pliers-tool-for-electric-cable?gad_source=1&gclid=Cj0KCQjwsaqzBhDdARIsAK2gqncaU1Ngl5J6GHbfCOqqF0jgnbM6MvZ0f-7W7bY6Bn7NYuMxdTzmu5waAi7tEALw_wcB',
  ),
  StoreModel(
    name: 'Bricoman',
    logo: 'assets/logos/bricoman.png',
    url: 'https://www.bricoman.fr/',
  ),
];
