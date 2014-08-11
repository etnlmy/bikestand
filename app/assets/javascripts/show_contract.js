$(".container.contracts.show").ready(function () {

  var contract = $('.contract').data('contract');

  function displayContractInfo(stations) {
    var nbOpenStations = 0, message;
    stations.forEach(function (station) {
      var record = station.last_record;
      if (!record) { return; }
      if (record.status === "OPEN") { nbOpenStations++; }
    });
    message = nbOpenStations === stations.length ?
        "<p>All the " + nbOpenStations + " stations are currently opened." :
        "<p>There are " + nbOpenStations + " open stations out of " + stations.length + "</p>";
    $("#contract-info").append(message);
  }

  $.getJSON("/api/contracts/" + contract.id + "/stations", function (stations) {
    contractMap.displayMap(stations, 'map-canvas');
    displayContractInfo(stations);
  });

});