var contractMap = (function () {
  var stations, div, map;

  function stationsBounds(stations) {
    var southWest = L.latLng(
        d3.min(stations.map(function (station) { return station.latitude; })),
        d3.min(stations.map(function (station) { return station.longitude; }))
      ),
      northEast = L.latLng(
        d3.max(stations.map(function (station) { return station.latitude; })),
        d3.max(stations.map(function (station) { return station.longitude; }))
      );
    return L.latLngBounds(southWest, northEast);
  }

  function ocupancyRateColorScale(ocupancyRate, status) {
    if (status !== "OPEN") {
      return "#ffffff";
    }
    if (ocupancyRate < 0.3) {
      return "#ca0020";
    }
    if (ocupancyRate >= 0.3 && ocupancyRate <= 0.7) {
      return "#1a9641";
    }
    return "#404040";
  }

  function markerForStation(station) {
    var position = L.latLng(station.latitude, station.longitude),
      record = station.last_record;
    if (!record) { throw "No record found for this station"; }

    var color = ocupancyRateColorScale(
        record.available_bike_stands / record.bike_stands,
        record.status
      );

    return L.circleMarker(
      position,
      {
        radius: 4,
        color: color,
        fillOpacity: 0.6
      }
    );
  }

  var displayMap = function (s, d) {
    stations = s;
    div = d;

    map = L.mapbox.map(div, 'examples.map-20v6611k');
    map.fitBounds(stationsBounds(stations));

    stations.forEach(function (station) {
      try {
        markerForStation(station).addTo(map);
      } catch (error) {
        console.log(error);
      }
    });

  };
  return {displayMap: displayMap};
}());