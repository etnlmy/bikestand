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

  });

  d3.json("cities.json", function(cities){

    var circles = svg.selectAll("a")
        .data(cities)
      .enter().append("a")
        .attr("xlink:href", "http://example.com")
      .append("circle")
        .attr("cx", function(d) { return x(d.long, d.lat) })
        .attr("cy", function(d) { return y(d.long, d.lat) })
        .attr("r", 6)
        .attr("class", "city"); 

    circles.append("a")
        .attr("href", "http://example.com");

    var tooltip = svg.selectAll("g")
      .data(cities)
    .enter().append("g")
      .attr("transform", function(d) { return "translate(" + x(d.long, d.lat) + ", " + y(d.long, d.lat)  + ")"; });

    var text = tooltip.append("text")
      .attr("dx", "1em")
      .attr("dy", "1em")
      .attr("class", "label")
      .text(function(d) { return d.name; });
  });

});
