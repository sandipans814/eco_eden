import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:camera/camera.dart';
//import 'camera_page.dart';


class HomePage extends StatefulWidget {
  const HomePage(
      {@required this.accEmail,
      this.accName}); //email mandat name can be obtained from database;
  final String accEmail;
  final String accName;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EcoEden',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
            ),
            padding: EdgeInsets.only(right: 20.0),
            splashColor: Color(0xFF4285f4),
            onPressed: () {
              print('Search is pressed');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.accName),
              accountEmail: Text(widget.accEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Item 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context); //Push Method will be added later
              },
            ),
            ListTile(
              title: Text(
                "Item 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context); //Push Method will be added later
              },
            ),
            showPrimaryButton(context),
          ],
        ),
      ),
      body: _child,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: (){
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          color: Color(0xEF4285f4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.home),
                  onPressed: null),
              IconButton(
                color: Colors.black,
                icon: Icon(FontAwesomeIcons.newspaper),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Home'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Home'),
      )
    ].toSet();
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}

Widget showPrimaryButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
    child: SizedBox(
      width: 30.0,
      height: 50.0,
      child: RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blue,
        child: Text(
          'Log Out',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupPage()),
          );
        },
      ),
    ),
  );
}
