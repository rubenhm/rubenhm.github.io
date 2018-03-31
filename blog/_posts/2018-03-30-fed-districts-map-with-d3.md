---
layout: post
title: "Fed Districts Map with D3"
description: "choropleth map of federal reserve districts with d3.js"
category: "blog"
tags: [d3, javascript, cartography, maps]
---


The goal is to generate a map of the 12 Federal Reserve Districts using d3.js.

Here is the final result:

<div class="map-container">
  <iframe src="/downloads/blog/2018-03-30-fed-districts-map-with-d3/fed-districts.html" frameborder="0" allowfullscreen marginwidth="0" marginheight="0" style="height:600px;" scrolling="no">
  </iframe>
</div>
<div class="index-pop">
    <a target="_blank" title="Open map in a new window." href="/downloads/blog/2018-03-30-fed-districts-map-with-d3/fed-districts.html">Open<svg height="16" width="12"><path d="M11 10h1v3c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V3c0-0.55 0.45-1 1-1h3v1H1v10h10V10zM6 2l2.25 2.25-3.25 3.25 1.5 1.5 3.25-3.25 2.25 2.25V2H6z"></path></svg></a>
</div>

The historical definitions of the Fed Districts are available from [FRASER](https://fraser.stlouisfed.org/files/docs/historical/federal%20reserve%20history/frdistricts/frb_districts_199603.pdf), a service for archival information from the St. Louis Fed.

The county definitions in the PDF were manually coded into a [CSV file](/downloads/blog/2018-03-30-fed-districts-map-with-d3/counties-by-fed-district.csv).
Over time, some of the county definitions [have changed](https://www.census.gov/geo/reference/county-changes.html) but some may have been missed, so clearly, this file does not represent official definitions.

## Choropleth map

The Fed Districts map is a straight-up modification of the recent example of a choropleth map for unemployment rates by [Mike Bostock](https://bl.ocks.org/mbostock/4060606). He uses a threshold scale and the blues color scheme which work great for a continuous variable such as the unemployment rate, but are probably not the best choice for a categorical map with 12 categories! For one, the blues color scheme does not even have 12 categories. So I went over to [ColorBrewer](http://colorbrewer2.org/#type=qualitative&scheme=Set3&n=12) and select a scheme with soft colors for qualitative data with 12 categories.

I replaced the CSV file for the unemployment rates with the Fed Districts definitions and I added code to define the boundaries between Districts using `topojson.mesh` in the same way as Mike generated the boundaries between states.

I also learned about `map()` to define dictionary-like variables that contain useful information about each county to display on hover.

Notice that the Fed District numbers are defined in a Westerly direction.

```
<!DOCTYPE html>
<meta charset="utf-8">
<style>

.counties {
  fill: none;
}

.states {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
}

.districts {
  fill: none;
  stroke: #808080;
  stroke-linejoin: round;
  stroke-width: 1.5px;
}

</style>
<svg width="960" height="600"></svg>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>
<script src="https://d3js.org/topojson.v2.min.js"></script>
<script>

var svg = d3.select("svg"),
    width = +svg.attr("width"),
    height = +svg.attr("height");

// Define maps with definitions and county and District names
var frbdefinitions = d3.map();
var countynames    = d3.map();
var districtNames  = d3.map();

// Harcoded Fed District denominations
// The city name indicates the city of the main office
// Notice that the district numbers are defined in a Westerly direction 
districtNames.set(1,"Boston")
districtNames.set(2,"Philadelphia")
districtNames.set(3,"New York")
districtNames.set(4,"Cleveland")
districtNames.set(5,"Richmond")
districtNames.set(6,"Atlanta")
districtNames.set(7,"Chicago")
districtNames.set(8,"St. Louis")
districtNames.set(9,"Minneapolis")
districtNames.set(10,"Kansas City")
districtNames.set(11,"Dallas")
districtNames.set(12,"San Francisco")

var path = d3.geoPath();

var x = d3.scaleLinear()
    .domain([0, 12])
    .rangeRound([600, 860]);

var color = d3.scaleThreshold()
    .domain(d3.range(1, 13))
    .range(['#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3','#fdb462','#b3de69','#fccde5','#d9d9d9','#bc80bd','#ccebc5','#ffed6f']);

var g = svg.append("g")
    .attr("class", "key")
    .attr("transform", "translate(0,40)");

g.selectAll("rect")
  .data(color.range().map(function(d) {
      d = color.invertExtent(d);
      if (d[0] == null) d[0] = x.domain()[0];
      if (d[1] == null) d[1] = x.domain()[1];
      return d;
    }))
  .enter().append("rect")
    .attr("height", 8)
    .attr("x", function(d) { return x(d[0]); })
    .attr("width", function(d) { return x(d[1]) - x(d[0]); })
    .attr("fill", function(d) { return color(d[0]); });

g.append("text")
    .attr("class", "caption")
    .attr("x", x.range()[0])
    .attr("y", -6)
    .attr("fill", "#000")
    .attr("text-anchor", "start")
    .attr("font-weight", "bold")
    .text("Fed District");

g.call(d3.axisBottom(x)
    .tickSize(13)
    .tickFormat(function(x, i) { return i ? x : x ; })
    .tickValues(color.domain()))
  .select(".domain")
    .remove();

d3.queue()
    .defer(d3.json, "https://d3js.org/us-10m.v1.json")
    .defer(d3.csv, "counties-by-fed-district.csv", function(d) { 
    	frbdefinitions.set(d.countyfips, +d.dist_frb); 
        countynames.set(d.countyfips, d.county_name+", "+d.state_abbr);
      })
    .await(ready);

function ready(error, us) {
  if (error) throw error;

  // Select fill color for Fed Districts using the map for the definitions
  // and the color scheme defined earlier
  // Also add information to each county to be displayed on hover
  svg.append("g")
      .attr("class", "counties")
    .selectAll("path")
    .data(topojson.feature(us, us.objects.counties).features)
    .enter().append("path")
      .attr("fill", function(d) { return color(d.dist_frb  = frbdefinitions.get(d.id) -1); })
      .attr("d", path)
    .append("title")
      .text(function(d) { 
        return "District: " + (+d.dist_frb + 1) + ". " +
               districtNames.get(+d.dist_frb + 1) + "\n" +
               "County fips: " + d.id + "\n" +
               "County name: " + countynames.get(d.id)});

  // Define boundaries for states
  svg.append("path")
      .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
      .attr("class", "states")
      .attr("d", path);

  // Define boundaries for Fed Districts using counties
  svg.append("path")
      .datum(topojson.mesh(us, us.objects.counties, function(a, b) { 
        return (frbdefinitions.get(a.id) !== frbdefinitions.get(b.id)) & (a !== b); }))
      .attr("class", "districts")
      .attr("d", path);

}

</script>
```