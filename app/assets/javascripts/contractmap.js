var contractMap = function () {

  var contract, div, layer, map;

  function stationsBounds(stations) {
    var southWest = L.latLng(
      d3.min(stations.map(function(station) { return station.latitude; })),
      d3.min(stations.map(function(station) { return station.longitude; }))),
        northEast = L.latLng(
      d3.max(stations.map(function(station) { return station.latitude; })),
      d3.max(stations.map(function(station) { return station.longitude; })));
    return L.latLngBounds(southWest, northEast);
  }

  function markerForStation(station) {
    var position = L.latLng(station.latitude, station.longitude);
    var record = station.last_record;
    if (!record) { throw "No record found for this station"; }

    var color = ocupancyRateColorScale(
      record.available_bike_stands / record.bike_stands, 
      record.status);

    return L.circleMarker(
      position, 
      {
        radius: 4,
        color: color,
        fillOpacity: 0.6
      });
  }

  function ocupancyRateColorScale(ocupancyRate, status) {
    if (status !== "OPEN") {
      return "#ffffff";
    }
    if (ocupancyRate < 0.3) {
      return "#ca0020";
    }
    else if (ocupancyRate >= 0.3 && ocupancyRate <= 0.7) {
      return "#1a9641";
    }
    else {
      return "#404040";
    }
  }

  var displayMap = function (s, d) {
    stations = s;
    div = d;

    map = L.mapbox.map(div, 'examples.map-20v6611k');
    map.fitBounds(stationsBounds(stations));
    var markers = 

    stations.forEach(function(station) {
      try {
        markerForStation(station).addTo(map); 
      }
      catch (error) {console.log(error)}
    });  

  };
  return {displayMap: displayMap}
}();