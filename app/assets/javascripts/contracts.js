$(function() {

  var width = 700,
    height = 800;

  var projection = d3.geo.mercator()
      .scale(600)
      .translate([width / 3, 1150]);

  var svg = d3.select(".well").append("svg")
      .attr("width", width)
      .attr("height", height);

  var x = function(long, lat) {
    return projection([long, lat])[0];
  }

  var y = function(long, lat) {
    return projection([long, lat])[1];
  }

  function capitaliseFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  d3.json("western_europe.json", function(error, we) {
    if (error) return console.error(error);

    var subunits = topojson.feature(we, we.objects.western_europe_subunits_clipped);

    var path = d3.geo.path()
      .projection(projection);

    svg.append("path")
      .datum(subunits)
      .attr("d", path);

    svg.selectAll(".subunit")
      .data(topojson.feature(we, we.objects.western_europe_subunits_clipped).features)
    .enter().append("path")
      .attr("class", function(d) { return "subunit " + d.id; })
      .attr("d", path);

    d3.json("api/contracts.json", function(cities){

      var citiesLinks = svg.selectAll("a")
          .data(cities)
        .enter().append("a")
          .attr("xlink:href", function(d) { return "contracts/" + d.id })
          .attr("class", "city");

      citiesLinks.append("circle")
          .attr("cx", function(d) { return x(d.longitude, d.latitude) })
          .attr("cy", function(d) { return y(d.longitude, d.latitude) })
          .attr("r", 5)
          .attr("class", "citycircle");

      citiesLinks.append("text")
          .attr("dx", "0.7em")
          .attr("dy", "0.7em")
          .attr("class", "citylabel")
          .attr("transform", function(d) { return "translate(" + x(d.longitude, d.latitude) + ", " + y(d.longitude, d.latitude)  + ")"; })
          .text(function(d) { return capitaliseFirstLetter(d.name); });

    });  

  });

});
