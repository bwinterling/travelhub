$(document).ready(function() {
  $.getJSON('http://localhost:3000/api/v1/checkins', function(data) {
    window.data = data;
  });
});

// var map = L.mapbox.map('map', 'rsoden.map-wjcj2udt')
//       .setView([ <%= @checkins.last.venue_latitude %> , <%= @checkins.last.venue_longitude %> ], 13);

//       map.touchZoom.disable();
//       map.doubleClickZoom.disable();
//       map.scrollWheelZoom.disable();
//       if (map.tap) map.tap.disable();


// L.control.layers({
//       'Base Map': L.mapbox.tileLayer('rsoden.map-wjcj2udt').addTo(map),
//       'Grey Map': L.mapbox.tileLayer('examples.map-20v6611k')
//   }).addTo(map);

// var markerLayer = L.mapbox.markerLayer({
//         type: 'FeatureCollection',
//         features: data
//         }).addTo(map);

// var geojsonMarkerOptions = {
//     radius: 8,
//     fillColor: "#ff7800",
//     color: "#000",
//     weight: 1,
//     opacity: 1,
//     fillOpacity: 0.8
//   };

// L.geoJson(someGeojsonFeature, {
//     pointToLayer: function (feature, latlng) {
//         return L.circleMarker(latlng, geojsonMarkerOptions);
//     }
// }).addTo(map);
