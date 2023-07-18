class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: "Bienvenido a Uplink",
      image: "images/image1.png",
      // image: "images/rosario1.jpg",
      description: "La red social no oficial de la UPCHIAPAS"),
  UnbordingContent(
      title: "Conéctate",
      image: "images/image2.png",
      // image: "images/rosario2.jpeg",
      description: "Con todos tus compañeros dentro de la universidad"),
  UnbordingContent(
      title: "Conecta con tus profesores",
      image: "images/image3.png",
      // image: "images/rosario3.jpg",
      description: "Conocelos y descubre cosas relacionadas a sus materias"),
];
