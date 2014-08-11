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
      return "#404040";
    }
    if (ocupancyRate >= 0.3 && ocupancyRate <= 0.7) {
      return "#1a9641";
    }
    return "#ca0020";
  }

  function markerForStation(station) {
    var position = L.latLng(station.latitude, station.longitude),
      record = station.last_record,
      color,
      popup,
      popupContent;

    if (!record) { throw "No record found for this station"; }

    color = ocupancyRateColorScale(
      record.available_bike_stands / record.bike_stands,
      record.status
    );
    var format = d3.time.format("%x at %X");
    popupContent = "<p>" + station.name + "</p>" +
                   "<p>" + record.available_bikes + " bikes available</p>" +
                   "<p>" + record.available_bike_stands + " slots available</p>" +
                   "<p> updated on " + format(new Date(record.last_update)) + "</p>";

    popup = L.popup()
        .setLatLng(position)
        .setContent(popupContent);

    return L.circleMarker(
      position,
      {
        radius: 4,
        color: color,
        fillOpacity: 0.6
      }
    ).on('mouseover', function () {
      popup.openOn(map);
    });
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