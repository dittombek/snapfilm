class DataModel {
  const DataModel({
    required this.backgroundImage,
    required this.posterImage,
    required this.title,
    required this.genres,
    required this.rate,
    required this.director,
    required this.actors,
    required this.introduction,
    required this.trailer,
  });

  final String backgroundImage;
  final String posterImage;
  final String title;
  final List<String> genres;
  final double rate;
  final String director;
  final List<Map<String, String>> actors;
  final String introduction;
  final String trailer;
}

// dummy json database of three films
List<DataModel> dataList = [
  const DataModel(
    backgroundImage: 'assets/posters/ironman3_background_image.jpeg',
    posterImage: 'assets/posters/ironman3_poster_image.jpeg',
    title: 'Iron Man 3',
    genres: ['Action', 'Adventure', 'Sci-Fi'],
    rate: 7.1,
    director: 'Shane Black',
    actors: [
      {
        'photoActor': 'assets/actors/Robert_Downey_Jr..jpeg',
        'nameActor': 'Robert Downey Jr.',
      },
      {
        'photoActor': 'assets/actors/Gwyneth_Paltrow.jpeg',
        'nameActor': 'Gwyneth Paltrow',
      },
      {
        'photoActor': 'assets/actors/Don_Cheadle.jpeg',
        'nameActor': 'Don Cheadle',
      },
    ],
    introduction:
        'When Tony Stark\'s world is torn apart by a formidable terrorist called the Mandarin, he starts an odyssey of rebuilding and retribution.',
    trailer: 'assets/trailers/iron_man_3.mp4',
  ),
  const DataModel(
    backgroundImage: 'assets/posters/oppenheimer_background_image.jpeg',
    posterImage: 'assets/posters/oppenheimer_poster_image.jpeg',
    title: 'Oppenheimer',
    genres: ['Biography', 'Drama', 'History'],
    rate: 8.3,
    director: 'Christopher Nolan',
    actors: [
      {
        'photoActor': 'assets/actors/Cillian_Murphy.jpeg',
        'nameActor': 'Cillian Murphy',
      },
      {
        'photoActor': 'assets/actors/Matt_Damon.jpeg',
        'nameActor': 'Matt Damon',
      },
      {
        'photoActor': 'assets/actors/Robert_Downey_Jr..jpeg',
        'nameActor': 'Robert Downey Jr.',
      },
    ],
    introduction:
        'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
    trailer: 'assets/trailers/oppenheimer.mp4',
  ),
  const DataModel(
    backgroundImage: 'assets/posters/interstellar_background_image.jpeg',
    posterImage: 'assets/posters/interstellar_poster_image.jpeg',
    title: 'Interstellar',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    rate: 8.7,
    director: 'Christopher Nolan',
    actors: [
      {
        'photoActor': 'assets/actors/Matthew_McConaughey.jpeg',
        'nameActor': 'Matthew McConaughey',
      },
      {
        'photoActor': 'assets/actors/Jessica_Chastain.jpeg',
        'nameActor': 'Jessica Chastain',
      },
      {
        'photoActor': 'assets/actors/Anne_Hathaway.jpeg',
        'nameActor': 'Anne Hathaway',
      },
    ],
    introduction:
        'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.',
    trailer: 'assets/trailers/interstellar.mp4',
  ),
];
