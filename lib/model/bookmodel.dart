
class BookModel {
  BookModel(
      {this.bookName,
      this.discription,
      this.bookImage,
      this.totalCost,
      this.totalPages,
      this.authorName,
      this.authorImage,
      this.ratings,
      this.bookType,
      this.pdfUrl});

  String? bookName;
  String? discription;
  String? bookImage;
  int? totalCost;
  int? totalPages;
  String? authorName;
  String? authorImage;
  int? ratings;
  String? bookType;
  String? pdfUrl;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        bookName: json["bookName"],
        discription: json["discription"],
        bookImage: json["bookImage"],
        totalCost: json["totalCost"],
        totalPages: json["totalPages"],
        authorName: json["authorName"],
        authorImage: json["authorImage"],
        ratings: json["ratings"],
        bookType: json["bookType"],
        pdfUrl: json["pdfUrl"],
      );

  Map<String, dynamic> toJson() => {
        "bookName": bookName,
        "discription": discription,
        "bookImage": bookImage,
        "totalCost": totalCost,
        "totalPages": totalPages,
        "authorName": authorName,
        "authorImage": authorImage,
        "ratings": ratings,
        "bookType": bookType,
        "pdfUrl": pdfUrl,
      };
}

List<BookModel> getModelBookList() {
  return <BookModel>[
    BookModel(
      bookName: "An Anonymous Girl",
      discription:
          "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
      authorName: "Greer Hendricks",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fgreer_hendricks.jpg?alt=media&token=a1d8760d-fd43-4f71-a30c-91558421ed8e",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fan_anonymous_girl_by_greer_hendricks.jpg?alt=media&token=379359e7-a13b-45ee-b221-d39ad2ad101e",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2FAn%20Anonymous%20Girl.pdf?alt=media&token=e83265d5-b569-45fd-8967-953636672eab",
    ),
    BookModel(
      bookName: "The Water Cure",
      discription:
          "The Water Cure has drawn instant comparisons to The Handmaid’s Tale, and not just because author Margaret Atwood called it “a gripping, sinister fable.” The book centers on Grace, Lia, and Sky, three sisters who live on an isolated island with their mother and their father, whom they call King. When their father disappears, their lives—as well as everything they’ve been told about the outside world—are upended.",
      authorName: "Sophie Mackintosh",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fsophie_mackintosh.jpg?alt=media&token=4e5ffb6d-1536-42f0-aad3-3b55fdb4dcbf",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_water_cure_by_sophie_mackintosh.jpg?alt=media&token=aa19f2b5-227e-4733-87cb-626a877d9e2b",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Dreamers",
      discription:
          "Set in a Southern California college town, The Dreamers begins with the odd case of a student who walks into her dorm room, passes out, and doesn’t wake up. Soon a second girl falls asleep, then a third, and on it goes. The victims are locked in a heightened dream state, having wild fantasies and hallucinations—all while a group of students, teachers, and doctors struggle to wake them.",
      authorName: "Karen Thompson",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fkaren_thompson_walker.jpg?alt=media&token=87c6dfcc-c7d8-4d8d-a2a9-d24075fbf2b1",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_dreamers_by_karen_thompson.jpg?alt=media&token=d6b1fcca-3dae-400a-a14f-bade1b0d0ae3",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "Maid",
      discription:
          "Growing up, Land had always planned on escaping her hometown and becoming a writer. But after an unexpected pregnancy, her dreams were put on hold. She became a housekeeper, went on food stamps, and at times lived in government housing to make ends meet. All the while she took online college classes and wrote stories about the people around her: working-class Americans. Land's memoir is this year’s Educated; you’ll love her fighting spirit and learn from her look at poverty in the United States..",
      authorName: "Stepanie Land",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fstepanie_land.jpg?alt=media&token=68d033c9-fc88-4153-aa50-27456181c4c7",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fmaid_by_stepanie_land.jpg?alt=media&token=226e23d3-08c4-43fd-a48a-ecd3a4a3ffcd",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Suspect",
      discription:
          "If you obsessively followed the stories of Natalee Holloway, Madeleine McCann, and Jayme Closs, read The Suspect. From the author of the New York Times best-seller The Widow, Barton’s latest novel centers on what happens when two girls vanish in Thailand. With the girls’ families thrown into the international spotlight, journalists descend to crack the case. But as this thriller unfolds, it becomes clear the real danger is closer to home. The Suspect is an edge-of-your-seat suspense novel about a parent’s worst nightmare.",
      authorName: "Fiona Barton",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Ffiona_barton.jpg?alt=media&token=ed514fdd-6554-4002-a1ab-3d71ad291877",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_suspect_by_fiona_barton.jpg?alt=media&token=788143ff-af19-48b7-a892-7dd65fe22bf7",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Lost Girls of Paris",
      discription:
          "Jenoff, the author of New York Times best-seller The Orphan’s Tale, is back with a novel about a group of female secret agents during World War II. Based on a series of real-life events, the book opens in Manhattan in 1946, when a woman discovers a suitcase that belonged to the leader of a network of spies based in London during the war. What follows is a portrait of sisterhood, courage, and drama. A must-read.",
      authorName: "Pam Jenoff",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fpam_jenoff.jpg?alt=media&token=44bd7128-8d99-427b-a498-454c1905ef52",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_lost_girls_of_paris_by_pam_jenoff.jpg?alt=media&token=a30ac980-65fd-45dc-aadf-3e6fe89bedec",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Age of Light",
      discription:
          "Is “woman behaves dangerously, lives wildly” a genre? If so, The Age of Light is its latest poster child. The novel is a work of historical fiction about Lee Miller, a real-life Vogue model who became one of the first female war correspondents. Scharer’s plot takes off when Miller travels to Paris where she meets photographer Man Ray, who becomes her collaborator and lover. While most stories about Miller paint her as Ray’s muse, this one portrays her as the independent and daring artist she truly was.",
      authorName: "Whitney Scharer",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fwhitney_scharer.jpg?alt=media&token=9d8f1791-5147-4ac7-968e-cb80ae354056",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_age_of_light_by_whitney_scharer.jpg?alt=media&token=7d83aeab-ce6f-430a-9e59-ee22f720bf2c",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Last Romantics",
      discription:
          "The second novel from the writer behind New York Times best-seller The House Girl is a modern epic. When poet Fiona Skinner is asked about the inspiration behind her most famous work, she begins to trace the arc of her childhood. She recalls her father's unexpected death, her mother's descent into a paralyzing depression, and her siblings' determined survival. Her father's death shaped each of their lives and still haunts Fiona in her work. In the vein of Commonwealth, The Last Romantics is a sweeping look at what binds families together.",
      authorName: "Tara Conklin",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Ftara_conklin.jpg?alt=media&token=dcc5c9af-8ccd-4a0a-8e38-7fc68ff002a5",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_last_romantics_by_tara_conklin.jpg?alt=media&token=dcdd7e21-17d3-46c4-b032-73c9f490d2c9",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Night Tiger",
      discription:
          "Set in the 1930s in Malaysia, The Night Tiger opens when 11-year-old houseboy Ren discovers his master has just died. The master's final wish was for Ren to find the man’s finger—which he’d lost years before in an accident—so it can be buried with him. If the boy fails to find it, his master will be cursed and his soul will forever wander the earth. Across the district, Ji Lin, an apprentice dressmaker and dance hall girl by night, comes across an item that one of her dance partners has left behind, which sends her on her own adventure. Ren’s and Ji Lin’s paths soon crisscross as they embark on their journeys. It’s a book for fans of Isabel Allende and for those who love a murder mystery with a beautiful backdrop.",
      authorName: "Yangsze Choo",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fyangsze_choo.jpg?alt=media&token=853365ac-e95c-444d-9927-532128f607b5",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_night_tiger_by_yangsze_choo.jpg?alt=media&token=a017f2d7-e39d-46bc-a122-07eb1f81c0ac",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "The Lost Night",
      discription:
          "If you couldn't get enough of TBS's Search Party, or more recently Netflix's Russian Doll, pick up a copy of The Lost Night. Much like these two shows, this book also centers on a young woman posing as an amateur detective to solve a murder. Back in 2009 the novel's protagonist, Lindsay, partied with her friends and the queen bee of their group, Edie. After a long night of binge drinking, Lindsay woke up to find Edie dead of an apparent suicide. Now, a decade later, Lindsay discovers new evidence that could prove that Edie was murdered—and that Lindsay might have been involved. The rest of this haunting debut follows Lindsay as she tries to piece together what really happened on that awful, forgotten night.",
      authorName: "Andrea Bartz",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fandrea_bartz.jpg?alt=media&token=6f39419f-3af5-4005-b904-86f284bf1001",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fthe_lost_night_by_andrea_bartz.jpg?alt=media&token=7583c643-861c-4a1a-afe9-18cc61d58602",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
    BookModel(
      bookName: "You Know You Want This",
      discription:
          "Roupenian broke the Internet when The New Yorker published her viral short story “Cat Person” in 2017. Quick refresher: It was about a college-age girl who sleeps with an older man because she feels like she “owes” it to him, not quite because she wants to. In her debut collection, Roupenian continues to explore the inner workings of sex, trauma, kinks, and manipulation.",
      authorName: "Kristen Roupenian",
      authorImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/AuthorImages%2Fkristen_roupenian.jpg?alt=media&token=e80a942f-b327-4e2d-8efc-f3bcb0f3962f",
      bookImage:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/BooksImages%2Fyou_know_you_want_this_by_kristen_roupenian.jpg?alt=media&token=870a1372-8dba-43f8-9627-c3e4baef44b9",
      ratings: 4,
      bookType: "classic",
      totalCost: 100,
      totalPages: 100,
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/bookd-9d1b9.appspot.com/o/Books%2Fthedreamers.pdf?alt=media&token=2be016cb-7974-437e-9098-b16f73756cb3",
    ),
  ];
}
