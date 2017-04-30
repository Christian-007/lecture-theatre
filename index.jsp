<!DOCTYPE html>
<html>
  <head>
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    <!-- Vendor CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome/css/font-awesome.min.css">
    <!-- <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,700" rel="stylesheet"> -->
    <link href='https://fonts.googleapis.com/css?family=Product+Sans:300,400,700' rel='stylesheet' type='text/css'>

    <!-- Style CSS -->
    <link href="css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
  </head>
  <body>

    <div id="map"></div>
    <div class="button-left">
      <button class="menu-bars"><i class="fa fa-bars fa-lg" aria-hidden="true"></i> MENU</button>
      <div class="menus">
        <button class="find-theatres">Find Lecture Theatres</button>
      </div>
    </div>
    <div id="right-panel">
      <a class="close-side" href=""><i class="fa fa-close fa-lg" aria-hidden="true"></i></a>

      <div class="details">
        <h3>Results</h3>
        <!-- <p class="address"><i class="fa fa-map-marker fa-lg" aria-hidden="true"></i>   b.address  </p>  -->
        <div id="information"></div>
        <div id="directions-panel"></div>
      </div>
      <!-- <div class="search-bar">
        <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-default" type="button">Find All Lecture Theatres</button>
          </span>
        </div>
      </div>
      <hr>
      <h2>Results</h2>
      <ul id="places"></ul>-->
    </div>
    <script>
      // Note: This example requires that you consent to location sharing when
      // prompted by your browser. If you see the error "The Geolocation service
      // failed.", it means you probably did not give permission for the browser to
      // locate you.
      var map, infoWindow, myPosition;

      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 16,
          mapTypeControl: false, // remove map | satelite control
          zoomControl: true,
          zoomControlOptions: {
              position: google.maps.ControlPosition.LEFT_BOTTOM
          },
          scaleControl: true,
          streetViewControl: false,
          styles: [
            {
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#f5f5f5"
                }
              ]
            },
            {
              "elementType": "labels.icon",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
            {
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#616161"
                }
              ]
            },
            {
              "elementType": "labels.text.stroke",
              "stylers": [
                {
                  "color": "#f5f5f5"
                }
              ]
            },
            {
              "featureType": "administrative.land_parcel",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#bdbdbd"
                }
              ]
            },
            {
              "featureType": "poi",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#eeeeee"
                }
              ]
            },
            {
              "featureType": "poi",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "featureType": "poi.park",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#e5e5e5"
                }
              ]
            },
            {
              "featureType": "poi.park",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#9e9e9e"
                }
              ]
            },
            {
              "featureType": "road",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#ffffff"
                }
              ]
            },
            {
              "featureType": "road.arterial",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "featureType": "road.highway",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#dadada"
                }
              ]
            },
            {
              "featureType": "road.highway",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#616161"
                }
              ]
            },
            {
              "featureType": "road.local",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#9e9e9e"
                }
              ]
            },
            {
              "featureType": "transit.line",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#e5e5e5"
                }
              ]
            },
            {
              "featureType": "transit.station",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#eeeeee"
                }
              ]
            },
            {
              "featureType": "water",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#c9c9c9"
                }
              ]
            },
            {
              "featureType": "water",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#9e9e9e"
                }
              ]
            }
          ]
        });

        infoWindow = new google.maps.InfoWindow;

        // Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };

            myPosition = pos;

            infoWindow.setPosition(pos);
            infoWindow.setContent("Your Location");
            infoWindow.open(map);

            var marker = new google.maps.Marker({
              position: pos,
              icon: {
                path: google.maps.SymbolPath.CIRCLE,
                scale: 5
              },
              map: map
            });      

            map.setCenter(pos);

          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
      }

      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }

      var markers = [];
      var directions = [];
      var totalData = 0;

      function findLocation() {
        $.ajax({
          type: "GET",
          url: "lecture_locations.json",
          dataType: "json",
          success: function(data) {
            var infoWindow = new google.maps.InfoWindow();
            var placesList = document.getElementById('places');
            var rightPanelInformation = document.getElementById('information');
            var userLocation = new google.maps.LatLng(myPosition.lat, myPosition.lng);
            var bounds = new google.maps.LatLngBounds();
            var marker;

            $.each(data, function(i, b) {
              // create marker from Lat and Lng
              marker = new google.maps.Marker({
                position: new google.maps.LatLng(b.lat, b.lng),
                icon: new google.maps.MarkerImage(
                  "https://www.google.co.uk/maps/vt/icon/name=assets/icons/poi/quantum/container_background-2-medium.png,assets/icons/poi/quantum/container-2-medium.png,assets/icons/poi/quantum/school-2-medium.png&highlight=ffffff,db4437,ffffff&color=ff000000?scale=2",
                  null, /* size is determined at runtime */
                  null, /* origin is 0,0 */
                  null, /* anchor is bottom center of the scaled image */
                  new google.maps.Size(20, 20)),
                map: map
              });

              bounds.extend(marker.getPosition());

              var buildingLocation = new google.maps.LatLng(b.lat, b.lng);
              var distance = calcDistance(userLocation, buildingLocation) + " km";

              var contentString = 
              '<hr><div class="img-bg"><img src="images/' + b.image + '"/></div>' +
              '<p class="building-name">' + b.building + '</p>' +
              '<div class="row"><div class="col-xs-8"><p class="building-type">' + b.address + '</p></div>' +
              '<div class="col-xs-4"><a href="#" class="navigate" id="' + i + '" data-location="' + b.location + '">' + 
              '<i class="fa fa-arrow-circle-up fa-lg" aria-hidden="true"></i> ' + distance + '</a>' +
              '<a href="#" class="close-navigate hidden" id="' + i + '"><i class="fa fa-arrow-left" aria-hidden="true"></i>'+ 
              ' back</a></div></div>';

              // create InfoWindow for address
              google.maps.event.addListener(marker, 'click', (function(a, i){
                return function() {
                  rightPanelInformation.innerHTML = null;
                  rightPanelInformation.innerHTML += contentString;
                  $('#right-panel').addClass('active');
                  $("#right-panel").removeClass("directions");
                  $("#directions-panel").removeClass("active");
                  $("#directions-panel").empty();
                  removeDirections();
                  if(markers.length > totalData){
                    markers[markers.length - 1].setMap(null);
                    markers.splice(markers.length - 1, 1);
                  }
                  marker = new google.maps.Marker({
                    position: new google.maps.LatLng(b.lat, b.lng),
                    zIndex: 2000,
                    map: map
                  });
                  markers.push(marker);
                }
              })(marker, i))

              rightPanelInformation.innerHTML += contentString;

              // Push the marker to the 'markers' array
              markers.push(marker);
              totalData += 1; 
            });
            map.fitBounds(bounds);
          }
        });
      }

      $(function() {
        $('.button-left').on('click', 'button.find-theatres', function() {
          removeAllMarkers();
          totalData = 0;
          findLocation();
          $(this).parent().removeClass('active');
          $('.button-left').removeClass('active');
          $('#right-panel').addClass('active');
          $("#right-panel").removeClass("directions");
        });

        $('.button-left').on('click', '.menu-bars', function() {
          if($(this).parent().hasClass('active')){
            $(this).parent().removeClass('active');
            $('.button-left .menus').removeClass('active');
          }else{
            $(this).parent().addClass('active');
            setTimeout(function(){
              $('.button-left .menus').addClass('active');
            }, 450);
          }
        });

        $('body').on('click', '.navigate', function() {
          var id = $(this).attr('id');
          clickEvent(id);
          $("#directions-panel").empty();
          $("#right-panel").addClass("directions");
          $("#directions-panel").addClass("active");
          removeDirections();
          direction($(this).data('location'));
          $('.navigate').addClass('hidden');
          $('.close-navigate').removeClass('hidden');
          setTimeout(function(){
            $('#right-panel').animate({
              scrollTop: 355
            }, 950);
          });
        });

        $('body').on('click', '.close-navigate', function(e) {
          e.preventDefault();
          $('.navigate').removeClass('hidden');
          $(this).addClass('hidden');
          $("#right-panel #information").empty();
          $("#directions-panel").removeClass("active");
          $("#directions-panel").empty();
          removeDirections();
          if(markers.length > totalData){
            markers[markers.length - 1].setMap(null);
            markers.splice(markers.length - 1, 1);
          }
          // removeAllMarkers();
          findLocation();
        });

        $('#right-panel a.close-side').on('click', function(e) {
          e.preventDefault();
          $("#right-panel").removeClass("active");
          $("#right-panel").removeClass("directions");
          $("#right-panel #information").empty();
          $("#directions-panel").removeClass("active");
          $("#directions-panel").empty();
          removeDirections();
          removeAllMarkers();
        });

      });

      function direction(location) {
        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('directions-panel'));

        directions.push(directionsDisplay);

        var request = {
          origin: myPosition,
          destination: location,
          travelMode: 'WALKING'
        }

        directionsService.route(request, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }

      function removeDirections() {
        for(var i=0; i<directions.length; i++){
          directions[i].setMap(null);
        }
      }

      function removeAllMarkers() {
        while(markers.length){
            markers.pop().setMap(null);
        }
      }

      function clickEvent(id){
        google.maps.event.trigger(markers[id], 'click');
      }

      // Calculates distance between user location and building location
      function calcDistance(p1, p2) {
        return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCc4c0gxFhk60g5E02Ih1uNn-RhuZolT94&libraries=places,geometry&callback=initMap"
    async defer></script>
  </body>
</html>