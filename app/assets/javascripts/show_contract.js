$(".container.contracts.show").ready(function() {

  var contract = $('.contract').data('contract');
  var map;

  google.maps.event.addDomListener(window, 'load', initialize);

  function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(contract.latitude, contract.longitude),
      // zoom: 8
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    retrieveStations();
  }

  function retrieveStations() {
    $.getJSON("/api/contracts/" + contract.id + "/stations", function(stations) {
      fitMapBounds(stations);
      displayStations(stations);
    });
  }

  function fitMapBounds(stations) {
    var southWest = new google.maps.LatLng(
      d3.min(stations.map(function(station) { return station.latitude; })),
      d3.min(stations.map(function(station) { return station.longitude; })));
    var northEast = new google.maps.LatLng(
      d3.max(stations.map(function(station) { return station.latitude; })),
      d3.max(stations.map(function(station) { return station.longitude; })));
    var bounds = new google.maps.LatLngBounds(
      southWest,
      northEast);
    map.fitBounds(bounds);
  }

  function displayStations(stations) {
    stations.forEach(function(station) {
      var position = new google.maps.LatLng(station.latitude, station.longitude);
      var r = 10;
      var circle = {
        path: 'M 0, 0 m -5, 0 a 5,5 0 1,0 10,0 a 5,5 0 1,0 -10,0',
        fillColor: '#fc8d59',
        fillOpacity: 0.8,
        scale: 1,
        strokeColor: '#fc8d59',
        strokeWeight: 1
      };
      var marker = new google.maps.Marker({
        position: position,
        icon: circle,
        map: map
      });
    }); 
  }

});

