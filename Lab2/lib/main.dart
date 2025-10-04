import 'package:flutter/material.dart';

// Funcția principală care pornește aplicația
void main() {
  runApp(MyApp());
}

// Widget-ul principal al aplicației
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning App', // Titlul aplicației
      theme: ThemeData(
        primarySwatch: Colors.teal, // Schema de culori principală
        fontFamily: 'Roboto', // Font-ul principal
        scaffoldBackgroundColor: Colors.grey[100], // Culoare de fundal a aplicației
      ),
      home: MainScreen(), // Ecranul principal
      debugShowCheckedModeBanner: false, // Ascunde banner-ul de debug
    );
  }
}

// Clasa pentru datele mock ale cursurilor
class Course {
  final String title; // Titlul cursului
  final String institution; // Instituția care oferă cursul
  final double rating; // Rating-ul cursului
  final String imageUrl; // URL-ul imaginii cursului
  final double progress; // Progresul cursului (pentru cursurile în progres)
  final String price; // Prețul cursului (pentru cursurile noi)
  final String duration; // Durata cursului
  final String lectures; // Numărul de lecții
  final List<String> skills; // Lista de abilități

  Course({
    required this.title,
    required this.institution,
    required this.rating,
    required this.imageUrl,
    this.progress = 0.0,
    this.price = '',
    this.duration = '',
    this.lectures = '',
    this.skills = const [],
  });
}

// Ecranul principal care conține toate componentele
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Index-ul tab-ului curent

  // Date mock pentru cursurile în progres
  final List<Course> continueWatchingCourses = [
    Course(
      title: 'UI/UX Design Essentials',
      institution: 'Tech Innovations University',
      rating: 4.7,
      imageUrl: 'assets/ui_ux_course.png',
      progress: 0.75, // 75% completat
    ),
    Course(
      title: 'Graphic Design Fundamentals',
      institution: 'Creative Arts Institute',
      rating: 4.5,
      imageUrl: 'assets/graphic_design_course.png',
      progress: 0.35, // 35% completat
    ),
  ];

  // Date mock pentru sugestiile de cursuri
  final List<Course> suggestedCourses = [
    Course(
      title: 'Typography and Layout Design',
      institution: 'Visual Communication College',
      rating: 4.7,
      imageUrl: 'assets/typography_course.png',
    ),
    Course(
      title: 'Branding and Identity Design',
      institution: 'Innovation and Design School',
      rating: 4.4,
      imageUrl: 'assets/branding_course.png',
    ),
    Course(
      title: 'Web Design Fundamentals',
      institution: 'Web Development University',
      rating: 4.6,
      imageUrl: 'assets/web_design_course.png',
    ),
  ];

  // Date mock pentru top cursuri
  final List<Course> topCourses = [
    Course(
      title: 'Animation and Motion Graphics',
      institution: 'Animation Institute of Digital Arts',
      rating: 4.8,
      imageUrl: 'assets/animation_course.png',
    ),
    Course(
      title: 'Game Design and Development',
      institution: 'Game Development Academy',
      rating: 4.4,
      imageUrl: 'assets/game_design_course.png',
    ),
    Course(
      title: 'Product Design and Innovation',
      institution: 'Product Design Institute',
      rating: 4.9,
      imageUrl: 'assets/product_design_course.png',
    ),
  ];

  // Detaliile cursului selectat pentru pagina de detalii
  final Course selectedCourse = Course(
    title: 'Typography and Layout Design',
    institution: 'Visual Communication College',
    rating: 4.7,
    imageUrl: 'assets/typography_course.png',
    price: '\$35',
    duration: '4 Weeks',
    lectures: '50+ Lectures',
    skills: ['Typography', 'Layout composition', 'Branding', 'Visual communication', 'Editorial design'],
  );

  @override
  Widget build(BuildContext context) {
    // Listă de ecrane pentru a naviga între ele
    final List<Widget> _screens = [
      _buildHomeScreen(),
      _buildCourseDetailScreen(), // Placeholder for Courses screen
      Container(child: Center(child: Text("Saved Screen"))), // Placeholder for Saved screen
      Container(child: Center(child: Text("Profile Screen"))), // Placeholder for Profile screen
    ];

    // Logica pentru a afișa ecranul de detalii sau ecranul principal
    Widget body;
    if (_currentIndex == 1 && _screens[_currentIndex] is! Container) { // Un mod simplu de a naviga la detalii
      body = _buildCourseDetailScreen();
    } else if (_currentIndex > 1) { // Afișează placeholder-ele
      body = _screens[_currentIndex];
    }
    else {
      body = _buildHomeScreen();
    }


    return Scaffold(
      body: body,
      bottomNavigationBar: _buildBottomNavigationBar(), // Bara de navigare de jos
    );
  }

  // Construiește ecranul principal
  Widget _buildHomeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0), // Padding general pentru tot conținutul
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
            children: [
              _buildHeader(), // Header-ul cu salutul și notificările
              SizedBox(height: 20), // Spațiu vertical
              _buildSearchBar(), // Bara de căutare
              SizedBox(height: 30), // Spațiu vertical
              _buildContinueWatchingSection(), // Secțiunea "Continue Watching"
              SizedBox(height: 30), // Spațiu vertical
              _buildCategoriesSection(), // Secțiunea cu categorii
              SizedBox(height: 30), // Spațiu vertical
              _buildSuggestionsSection(), // Secțiunea cu sugestii
              SizedBox(height: 30), // Spațiu vertical
              _buildTopCoursesSection(), // Secțiunea cu top cursuri
            ],
          ),
        ),
      ),
    );
  }

  // Construiește header-ul aplicației
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuie spațiul între elemente
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aliniază textul la stânga
          children: [
            Text(
              'Welcome Sidra', // Mesajul de bun venit
              style: TextStyle(
                fontSize: 24, // Dimensiunea fontului pentru salut
                fontWeight: FontWeight.bold, // Text îngroșat
                color: Colors.black, // Culoarea textului
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8), // Padding intern pentru iconița de notificare
          decoration: BoxDecoration(
            color: Colors.teal, // Culoarea de fundal verde
            borderRadius: BorderRadius.circular(12), // Colțuri rotunjite
          ),
          child: Icon(
            Icons.notifications, // Iconița de notificări
            color: Colors.white, // Culoarea iconiței
            size: 24, // Dimensiunea iconiței
          ),
        ),
      ],
    );
  }

  // Construiește bara de căutare
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Padding intern
      decoration: BoxDecoration(
        color: Colors.white, // Culoarea de fundal albă
        borderRadius: BorderRadius.circular(25), // Colțuri foarte rotunjite
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Umbră ușoară
            spreadRadius: 1, // Răspândirea umbrei
            blurRadius: 10, // Blur-ul umbrei
            offset: Offset(0, 2), // Offsetul umbrei
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search, // Iconița de căutare
            color: Colors.grey[400], // Culoarea iconiței
            size: 24, // Dimensiunea iconiței
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search', // Textul placeholder
                border: InputBorder.none, // Fără bordură
                hintStyle: TextStyle(
                  color: Colors.grey[400], // Culoarea hint-ului
                  fontSize: 16, // Dimensiunea fontului
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Construiește secțiunea "Continue Watching"
  Widget _buildContinueWatchingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
      children: [
        Text(
          'Continue Watching', // Titlul secțiunii
          style: TextStyle(
            fontSize: 20, // Dimensiunea fontului
            fontWeight: FontWeight.bold, // Text îngroșat
            color: Colors.black, // Culoarea textului
          ),
        ),
        SizedBox(height: 15), // Spațiu vertical
        // Construiește lista de cursuri în progres
        ...continueWatchingCourses.map((course) => _buildContinueCourseCard(course)).toList(),
      ],
    );
  }

  // Construiește cardul pentru un curs în progres
  Widget _buildContinueCourseCard(Course course) {
    return Container(
      margin: EdgeInsets.only(bottom: 15), // Margin inferior
      padding: EdgeInsets.all(10), // Padding intern
      decoration: BoxDecoration(
        color: Colors.white, // Culoarea de fundal
        borderRadius: BorderRadius.circular(15), // Colțuri rotunjite
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Umbră ușoară
            spreadRadius: 1, // Răspândirea umbrei
            blurRadius: 10, // Blur-ul umbrei
            offset: Offset(0, 2), // Offsetul umbrei
          ),
        ],
      ),
      child: Row(
        children: [
          // FIX: Am înlocuit Container cu Image.asset
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              course.imageUrl,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15), // Spațiu orizontal
          // Informațiile cursului
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aliniază textul la stânga
              children: [
                Text(
                  course.title, // Titlul cursului
                  style: TextStyle(
                    fontSize: 16, // Dimensiunea fontului
                    fontWeight: FontWeight.bold, // Text îngroșat
                    color: Colors.black, // Culoarea textului
                  ),
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Text(
                  course.institution, // Instituția
                  style: TextStyle(
                    fontSize: 12, // Dimensiunea fontului
                    color: Colors.grey[600], // Culoarea textului
                  ),
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Row(
                  children: [
                    Icon(
                      Icons.star, // Iconița de stea
                      color: Colors.orange, // Culoarea iconiței
                      size: 16, // Dimensiunea iconiței
                    ),
                    SizedBox(width: 4), // Spațiu orizontal mic
                    Text(
                      course.rating.toString(), // Rating-ul cursului
                      style: TextStyle(
                        fontSize: 12, // Dimensiunea fontului
                        color: Colors.grey[600], // Culoarea textului
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), // Spațiu vertical
                // Bara de progres
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: Colors.grey[200],
                        color: Colors.teal,
                        minHeight: 6,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${(course.progress * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construiește secțiunea cu categorii
  Widget _buildCategoriesSection() {
    // Lista categoriilor
    final categories = ['Graphic Design', 'User Interface', 'User Experience', 'Web Design', 'Animation'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuie spațiul între elemente
          children: [
            Text(
              'Categories', // Titlul secțiunii
              style: TextStyle(
                fontSize: 20, // Dimensiunea fontului
                fontWeight: FontWeight.bold, // Text îngroșat
                color: Colors.black, // Culoarea textului
              ),
            ),
            Text(
              'See All', // Link-ul "Vezi tot"
              style: TextStyle(
                fontSize: 14, // Dimensiunea fontului
                color: Colors.teal, // Culoarea textului
                fontWeight: FontWeight.w500, // Greutatea fontului
              ),
            ),
          ],
        ),
        SizedBox(height: 15), // Spațiu vertical
        // FIX: Am adăugat SingleChildScrollView pentru a preveni pixel overflow
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) => _buildCategoryChip(category)).toList(),
          ),
        ),
      ],
    );
  }

  // Construiește un chip pentru categorie
  Widget _buildCategoryChip(String category) {
    return Container(
      margin: EdgeInsets.only(right: 10), // Margin la dreapta
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding intern
      decoration: BoxDecoration(
        color: category == 'Graphic Design' ? Colors.teal : Colors.white, // Culoare specială pentru categoria selectată
        border: Border.all(
          color: Colors.teal.withOpacity(0.5), // Culoarea bordurii
          width: 1, // Grosimea bordurii
        ),
        borderRadius: BorderRadius.circular(20), // Colțuri rotunjite
      ),
      child: Text(
        category, // Numele categoriei
        style: TextStyle(
          color: category == 'Graphic Design' ? Colors.white : Colors.teal, // Culoarea textului
          fontSize: 14, // Dimensiunea fontului
          fontWeight: FontWeight.w500, // Greutatea fontului
        ),
      ),
    );
  }

  // Construiește secțiunea cu sugestii
  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuie spațiul între elemente
          children: [
            Text(
              'Suggestions for You', // Titlul secțiunii
              style: TextStyle(
                fontSize: 20, // Dimensiunea fontului
                fontWeight: FontWeight.bold, // Text îngroșat
                color: Colors.black, // Culoarea textului
              ),
            ),
            Text(
              'See All', // Link-ul "Vezi tot"
              style: TextStyle(
                fontSize: 14, // Dimensiunea fontului
                color: Colors.teal, // Culoarea textului
                fontWeight: FontWeight.w500, // Greutatea fontului
              ),
            ),
          ],
        ),
        SizedBox(height: 15), // Spațiu vertical
        // Lista orizontală de sugestii
        Container(
          height: 220, // Înălțimea containerului
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Scrolling orizontal
            itemCount: suggestedCourses.length, // Numărul de elemente
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navighează la pagina de detalii când se apasă pe curs
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _buildCourseDetailScreen()),
                  );
                },
                child: _buildSuggestionCard(suggestedCourses[index]), // Construiește cardul de sugestie
              );
            },
          ),
        ),
      ],
    );
  }

  // Construiește cardul pentru o sugestie
  Widget _buildSuggestionCard(Course course) {
    return Container(
      width: 180, // Lățimea cardului
      margin: EdgeInsets.only(right: 15), // Margin la dreapta
      decoration: BoxDecoration(
        color: Colors.white, // Culoarea de fundal
        borderRadius: BorderRadius.circular(15), // Colțuri rotunjite
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Umbră ușoară
            spreadRadius: 1, // Răspândirea umbrei
            blurRadius: 10, // Blur-ul umbrei
            offset: Offset(0, 2), // Offsetul umbrei
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
        children: [
          // FIX: Am înlocuit Container cu Image.asset
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              course.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Informațiile cursului
          Padding(
            padding: EdgeInsets.all(12), // Padding intern
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
              children: [
                Text(
                  course.title, // Titlul cursului
                  style: TextStyle(
                    fontSize: 14, // Dimensiunea fontului
                    fontWeight: FontWeight.bold, // Text îngroșat
                    color: Colors.black, // Culoarea textului
                  ),
                  maxLines: 2, // Maxim 2 linii
                  overflow: TextOverflow.ellipsis, // Trunchează textul cu "..."
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Text(
                  course.institution, // Instituția
                  style: TextStyle(
                    fontSize: 10, // Dimensiunea fontului
                    color: Colors.grey[600], // Culoarea textului
                  ),
                  maxLines: 1, // Maxim 1 linie
                  overflow: TextOverflow.ellipsis, // Trunchează textul cu "..."
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Row(
                  children: [
                    Icon(
                      Icons.star, // Iconița de stea
                      color: Colors.orange, // Culoarea iconiței
                      size: 12, // Dimensiunea iconiței
                    ),
                    SizedBox(width: 4), // Spațiu orizontal mic
                    Text(
                      course.rating.toString(), // Rating-ul cursului
                      style: TextStyle(
                        fontSize: 10, // Dimensiunea fontului
                        color: Colors.grey[600], // Culoarea textului
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construiește secțiunea cu top cursuri
  Widget _buildTopCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuie spațiul între elemente
          children: [
            Text(
              'Top Courses', // Titlul secțiunii
              style: TextStyle(
                fontSize: 20, // Dimensiunea fontului
                fontWeight: FontWeight.bold, // Text îngroșat
                color: Colors.black, // Culoarea textului
              ),
            ),
            Text(
              'See All', // Link-ul "Vezi tot"
              style: TextStyle(
                fontSize: 14, // Dimensiunea fontului
                color: Colors.teal, // Culoarea textului
                fontWeight: FontWeight.w500, // Greutatea fontului
              ),
            ),
          ],
        ),
        SizedBox(height: 15), // Spațiu vertical
        // Lista orizontală de top cursuri
        Container(
          height: 200, // Înălțimea containerului
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Scrolling orizontal
            itemCount: topCourses.length, // Numărul de elemente
            itemBuilder: (context, index) {
              return _buildTopCourseCard(topCourses[index]); // Construiește cardul de top curs
            },
          ),
        ),
      ],
    );
  }

  // Construiește cardul pentru un top curs
  Widget _buildTopCourseCard(Course course) {
    return Container(
      width: 160, // Lățimea cardului
      margin: EdgeInsets.only(right: 15), // Margin la dreapta
      decoration: BoxDecoration(
        color: Colors.white, // Culoarea de fundal
        borderRadius: BorderRadius.circular(15), // Colțuri rotunjite
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Umbră ușoară
            spreadRadius: 1, // Răspândirea umbrei
            blurRadius: 10, // Blur-ul umbrei
            offset: Offset(0, 2), // Offsetul umbrei
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
        children: [
          // FIX: Am înlocuit Container cu Image.asset
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              course.imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Informațiile cursului
          Padding(
            padding: EdgeInsets.all(10), // Padding intern
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
              children: [
                Text(
                  course.title, // Titlul cursului
                  style: TextStyle(
                    fontSize: 12, // Dimensiunea fontului
                    fontWeight: FontWeight.bold, // Text îngroșat
                    color: Colors.black, // Culoarea textului
                  ),
                  maxLines: 2, // Maxim 2 linii
                  overflow: TextOverflow.ellipsis, // Trunchează textul cu "..."
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Text(
                  course.institution, // Instituția
                  style: TextStyle(
                    fontSize: 9, // Dimensiunea fontului
                    color: Colors.grey[600], // Culoarea textului
                  ),
                  maxLines: 1, // Maxim 1 linie
                  overflow: TextOverflow.ellipsis, // Trunchează textul cu "..."
                ),
                SizedBox(height: 4), // Spațiu vertical mic
                Row(
                  children: [
                    Icon(
                      Icons.star, // Iconița de stea
                      color: Colors.orange, // Culoarea iconiței
                      size: 10, // Dimensiunea iconiței
                    ),
                    SizedBox(width: 4), // Spațiu orizontal mic
                    Text(
                      course.rating.toString(), // Rating-ul cursului
                      style: TextStyle(
                        fontSize: 9, // Dimensiunea fontului
                        color: Colors.grey[600], // Culoarea textului
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construiește ecranul cu detaliile cursului
  Widget _buildCourseDetailScreen() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header-ul paginii de detalii
            Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.all(20), // Padding intern
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(selectedCourse.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Butonul de înapoi
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8), // Padding intern
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4), // Culoare semi-transparentă
                            borderRadius: BorderRadius.circular(10), // Colțuri rotunjite
                          ),
                          child: Icon(
                            Icons.arrow_back, // Iconița de înapoi
                            color: Colors.white, // Culoarea iconiței
                            size: 24, // Dimensiunea iconiței
                          ),
                        ),
                      ),
                      // Butonul de bookmark
                      Container(
                        padding: EdgeInsets.all(8), // Padding intern
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), // Culoare semi-transparentă
                          borderRadius: BorderRadius.circular(10), // Colțuri rotunjite
                        ),
                        child: Icon(
                          Icons.bookmark_outline, // Iconița de bookmark
                          color: Colors.white, // Culoarea iconiței
                          size: 24, // Dimensiunea iconiței
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Conținutul cu detaliile cursului
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20), // Padding general
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
                  children: [
                    // Titlul și prețul cursului
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuie spațiul între elemente
                      crossAxisAlignment: CrossAxisAlignment.start, // Aliniază elementele sus
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Aliniază textul la stânga
                            children: [
                              Text(
                                selectedCourse.title, // Titlul cursului
                                style: TextStyle(
                                  fontSize: 22, // Dimensiunea fontului
                                  fontWeight: FontWeight.bold, // Text îngroșat
                                  color: Colors.black, // Culoarea textului
                                ),
                              ),
                              SizedBox(height: 8), // Spațiu vertical
                              Text(
                                selectedCourse.institution, // Instituția
                                style: TextStyle(
                                  fontSize: 16, // Dimensiunea fontului
                                  color: Colors.grey[600], // Culoarea textului
                                ),
                              ),
                              SizedBox(height: 8), // Spațiu vertical
                              Row(
                                children: [
                                  Icon(
                                    Icons.people, // Iconița pentru studenți
                                    color: Colors.teal, // Culoarea iconiței
                                    size: 16, // Dimensiunea iconiței
                                  ),
                                  SizedBox(width: 4), // Spațiu orizontal mic
                                  Text(
                                    '3.4k students already enrolled', // Numărul de studenți înscriși
                                    style: TextStyle(
                                      fontSize: 14, // Dimensiunea fontului
                                      color: Colors.grey[600], // Culoarea textului
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Prețul cursului
                        Text(
                          selectedCourse.price, // Prețul
                          style: TextStyle(
                            fontSize: 28, // Dimensiunea fontului
                            fontWeight: FontWeight.bold, // Text îngroșat
                            color: Colors.teal, // Culoarea textului
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25), // Spațiu vertical
                    // Secțiunea "Course Details"
                    Container(
                      padding: EdgeInsets.all(20), // Padding intern
                      decoration: BoxDecoration(
                        color: Colors.white, // Culoarea de fundal
                        borderRadius: BorderRadius.circular(15), // Colțuri rotunjite
                        border: Border.all(
                          color: Colors.teal.withOpacity(0.3), // Culoarea bordurii
                          width: 1, // Grosimea bordurii
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aliniază conținutul la stânga
                        children: [
                          // Titlul secțiunii
                          Row(
                            children: [
                              Text(
                                'Course Details', // Titlul
                                style: TextStyle(
                                  fontSize: 18, // Dimensiunea fontului
                                  fontWeight: FontWeight.bold, // Text îngroșat
                                  color: Colors.teal, // Culoarea textului
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15), // Spațiu vertical
                          // Descrierea cursului
                          Text(
                            'Visual Communication College\'s Typography and Layout Design course explores the art and science of typography and layout composition. Learn how to effectively use typefaces, hierarchy, alignment, and grid systems to create visually compelling designs. Gain hands-on experience in editorial design, branding, and digital layouts.', // Descrierea
                            style: TextStyle(
                              fontSize: 14, // Dimensiunea fontului
                              color: Colors.grey[700], // Culoarea textului
                              height: 1.5, // Înălțimea liniei
                            ),
                          ),
                          SizedBox(height: 8), // Spațiu vertical
                          // Link-ul "Read More"
                          Text(
                            'Read More...', // Textul link-ului
                            style: TextStyle(
                              fontSize: 14, // Dimensiunea fontului
                              color: Colors.teal, // Culoarea textului
                              fontWeight: FontWeight.w500, // Greutatea fontului
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25), // Spațiu vertical
                    // Informațiile despre curs (lecții, timp, certificare)
                    _buildCourseInfoRow(Icons.play_circle_outline, 'Lectures', selectedCourse.lectures),
                    SizedBox(height: 15), // Spațiu vertical
                    _buildCourseInfoRow(Icons.access_time, 'Learning Time', selectedCourse.duration),
                    SizedBox(height: 15), // Spațiu vertical
                    _buildCourseInfoRow(Icons.card_membership, 'Certification', 'Online Certificate'),
                    SizedBox(height: 25), // Spațiu vertical
                    // Secțiunea "Skills"
                    Text(
                      'Skills', // Titlul secțiunii
                      style: TextStyle(
                        fontSize: 18, // Dimensiunea fontului
                        fontWeight: FontWeight.bold, // Text îngroșat
                        color: Colors.black, // Culoarea textului
                      ),
                    ),
                    SizedBox(height: 15), // Spațiu vertical
                    // Lista de abilități
                    Wrap(
                      spacing: 10, // Spațiul orizontal între chipuri
                      runSpacing: 8, // Spațiul vertical între rânduri
                      children: selectedCourse.skills.map((skill) => _buildSkillChip(skill)).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Butonul de înrolare
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity, // Lățimea completă
                child: ElevatedButton(
                  onPressed: () {
                    // Acțiunea pentru butonul de înrolare
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Enrolled successfully!'), // Mesajul de confirmare
                        backgroundColor: Colors.teal, // Culoarea de fundal
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Culoarea butonului
                    padding: EdgeInsets.symmetric(vertical: 16), // Padding vertical
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Colțuri rotunjite
                    ),
                  ),
                  child: Text(
                    'ENROLL NOW', // Textul butonului
                    style: TextStyle(
                      color: Colors.white, // Culoarea textului
                      fontSize: 16, // Dimensiunea fontului
                      fontWeight: FontWeight.bold, // Text îngroșat
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construiește un rând cu informații despre curs
  Widget _buildCourseInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8), // Padding intern
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1), // Culoare semi-transparentă
            borderRadius: BorderRadius.circular(8), // Colțuri rotunjite
          ),
          child: Icon(
            icon, // Iconița
            color: Colors.teal, // Culoarea iconiței
            size: 20, // Dimensiunea iconiței
          ),
        ),
        SizedBox(width: 15), // Spațiu orizontal
        Expanded(
          child: Text(
            title, // Titlul informației
            style: TextStyle(
              fontSize: 16, // Dimensiunea fontului
              fontWeight: FontWeight.w500, // Greutatea fontului
              color: Colors.black, // Culoarea textului
            ),
          ),
        ),
        Text(
          value, // Valoarea informației
          style: TextStyle(
            fontSize: 16, // Dimensiunea fontului
            color: Colors.grey[600], // Culoarea textului
          ),
        ),
      ],
    );
  }

  // Construiește un chip pentru abilități
  Widget _buildSkillChip(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding intern
      decoration: BoxDecoration(
        color: Colors.grey[200], // Culoarea de fundal
        borderRadius: BorderRadius.circular(20), // Colțuri rotunjite
      ),
      child: Text(
        skill, // Numele abilității
        style: TextStyle(
          fontSize: 14, // Dimensiunea fontului
          color: Colors.grey[800], // Culoarea textului
          fontWeight: FontWeight.w500, // Greutatea fontului
        ),
      ),
    );
  }

  // Construiește bara de navigare de jos
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex, // Index-ul curent
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Schimbă index-ul curent
        });
      },
      type: BottomNavigationBarType.fixed, // Tipul barei de navigare
      backgroundColor: Colors.white, // Culoarea de fundal
      selectedItemColor: Colors.teal, // Culoarea elementului selectat
      unselectedItemColor: Colors.grey, // Culoarea elementelor neselectate
      selectedFontSize: 12, // Dimensiunea fontului pentru elementul selectat
      unselectedFontSize: 12, // Dimensiunea fontului pentru elementele neselectate
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home), // Iconița pentru Home
          label: 'Home', // Eticheta pentru Home
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school), // Iconița pentru Courses
          label: 'Courses', // Eticheta pentru Courses
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark), // Iconița pentru Saved
          label: 'Saved', // Eticheta pentru Saved
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person), // Iconița pentru Profile
          label: 'Profile', // Eticheta pentru Profile
        ),
      ],
    );
  }
}