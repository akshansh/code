// Create a new map, style it, and display it on the web
// Initialize and add the map

function initMap() {
  // The location of University Center, The New School
  var uc = {lat: 40.735291, lng: -73.993734};
  var psd = {lat:40.7353, lng: -73.9944};
  var dt = {lat:40.737047, lng: -73.992186};
  var mannes = {lat: 40.736519, lng: -73.996615};
  var parsonsEast = {lat: 40.734866, lng: -73.992776};
  var eugene = {lat: 40.735222, lng: -73.997483};
  var cntr = {lat: 40.735973, lng: -73.994818};

  // The map, centered to show all the pins
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 18, center: cntr});

  // The marker, positioned at different buildings of The New School
  var markerUC = new google.maps.Marker({position: uc, map: map, animation: google.maps.Animation.DROP, title: 'University Center, 63 5th Av'});
  var markerPSD = new google.maps.Marker({position: psd, map: map, animation: google.maps.Animation.DROP, title: 'Parsons, 66 5th Av'});
  var markerDT = new google.maps.Marker({position: dt, map: map, animation: google.maps.Animation.DROP, title: 'DT, 6E 16th St'});
  var markerMannes = new google.maps.Marker({position: mannes, map: map, animation: google.maps.Animation.DROP, title: 'Mannes, 55 W 13th St'});
  var markerPEast = new google.maps.Marker({position: parsonsEast, map: map, animation: google.maps.Animation.DROP, title: 'Parsons East, 25 E 13th St'});
  var markerEugene = new google.maps.Marker({position: eugene, map: map, animation: google.maps.Animation.DROP, title: 'Eugene Lang, 65 W 11th St'});
}
  
// Note: To change the icon, add this to the Marker : , icon: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'