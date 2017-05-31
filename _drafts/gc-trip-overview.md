---
layout: post
category: personal
title: 'Grand Canyon Trip - Overview'
date: 2017-05-30 17:47
tags:
- vacation
- road trip
---

My wife and I have planned three "big trips" that represent experiences we want our family to have while our kids are in our home. Given a family of six, traveling can be expensive (saving for 2-3 years) which means you only get a few of these before college hits and schedules go completely sideways. The first of these is getting ready to kick off tomorrow and I am incredibly excited. Tomorrow we will load everyone into our car and head out for a 16 day road trip that will depart from Knoxville, TN and take us to the Grand Canyon and 37 other (planned) destinations before arriving home. We expect to travel nearly 4,700 miles over these next few days with nearly 80 hours in the car. 

In order to help maintain a semblance of sanity while in the car, as well as to help the kids build lasting memories, my wife and daughter assembled notebooks/journals for each kid that, along with activity sheets, has a page to complete each day which prompts them to record their memories, include any pictures, thoughts, etc. This page and tose 



<a class="example-image-link" href="/images/big_trip_day_01.png" data-lightbox="example-1"><img class="example-image" src="/images/big_trip_day_01_sm.png" alt="image-1" /></a>



### Adgenda
- Day 1: Big Driving Day
- Day 2: Beach Day!
- Day 3: Swamp Visit/Afternoon Drive
- Day 4: The Alamo!
- Day 5: Long Drive Day
- Day 6: Carlsbad Caverns
- Day 7: Another Drive Day
- Day 8: Petrified Forest
- Day 9: Grand Canyon Day!
- Day 10: Horsehoe Bend/Monument Valley
- Day 11: National Museum of Nuclear Science
- Day 12: Cadillac Ranch!
- Day 13: VW Bug Ranch
- Day 14: USS Batfish Museum
- Day 15: Ft. Smith Historic Site
- Day 16: Home!

### Route Overview

<div id="map"></div>
<script>
    var stops = [
        {name: 'Home', lat: 35.9586595, lon: -84.065509},
        {name: 'SpringHill Suites', lat: 30.6816292, lon: -88.131592},
        {name: 'Biloxi Beach', lat: 30.3934879, lon: -88.9324761},
        {name: 'Lunar Lander Exhibit', lat: 30.3135084, lon: -89.6022461},
        {name: 'Sleep Inn and Suites', lat: 30.0009959, lon: -90.1886205},
        {name: 'Cajun Pride Swamp Tours', lat: 30.095049, lon: -90.4385764},
        {name: 'SpringHill Suites', lat: 29.6262022, lon: -95.6005171},
        {name: 'The Alamo', lat: 29.4259718, lon: -98.4883359},
        {name: 'San Antonio River Walk', lat: 29.423754, lon: -98.4866138 },
        {name: 'Courtyard', lat: 29.6036543, lon: -98.6002813},
        {name: 'Fairfield Inn and Suites', lat: 32.391971, lon: -104.2230587},
        {name: 'Carlsbad Caverns National Park', lat: 32.122342, lon: -104.6034896},
        {name: 'White Sands National Monument', lat: 32.7872448, lon: -106.3278756},
        {name: 'Quality Inn', lat: 32.8773207, lon: -105.9613014},
        {name: 'The Very Large Array - Visitors Center', lat: 34.0758546, lon: -107.6226157},
        {name: 'Comfort Inn', lat: 34.9353902, lon: -110.1352302},
        {name: 'Petrified Forest National Park', lat: 34.9849849, lon: -109.9189539},
        {name: 'Old Trail Museum', lat: 35.023735, lon: -110.6997387},
        {name: 'The Grand Canyon Railway Hotel', lat: 35.2519747, lon: -112.1936513},
        {name: 'Grand Canyon National Park', lat: 36.0922083, lon: -113.4049296},
        {name: 'Horseshoe Bend', lat: 36.8791631, lon: -111.512707},
        {name: 'Monument Valley', lat: 36.9980328, lon: -110.1006514},
        {name: 'TownePlace Suites', lat: 36.7669695, lon: -108.1467596},
        {name: 'National Museum of Nuclear Science & History', lat: 35.0659899, lon: -106.5360859},
        {name: 'TownePlace Suites', lat: 35.0591628, lon: -106.6220605},
        {name: 'Route 66 Auto Museum', lat: 34.9462409, lon: -104.6566946},
        {name: 'Russells Truck & Travel Center and Free Museum', lat: 35.1753441, lon: -103.1062639},
        {name: 'Cadillac Ranch', lat: 35.1890484, lon: -101.989501},
        {name: 'Fairfield Inn & Suites', lat: 35.1942548, lon: -101.7282028},
        {name: 'VW Slug Bug Ranch', lat: 35.2155488, lon: -101.3860163},
        {name: 'Tower Station and U-Drop Inn Café', lat: 35.2267144, lon: -100.2507983},
        {name: 'SpringHill Suites', lat: 35.6105613, lon: -97.5766786},
        {name: 'POPS Soda Ranch', lat: 35.6582813, lon: -97.337674},
        {name: 'USS Batfish Military Museum', lat: 35.7937827, lon: -95.3127712},
        {name: 'Fairfield Inn and Suites', lat: 36.0299458, lon: -95.8659799},
        {name: 'Fort Smith National Historic Site', lat: 35.388307, lon: -94.4319587},
        {name: 'SpringHill Suites', lat: 35.1459944, lon: -90.0549883}
    ];

    function initMap() {
        var pleasant_ks =  {lat: 39.036680, lng: -98.384473};

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: pleasant_ks, 
            fullscreenControl: true
        });

        for (var i = 0; i < stops.length; i++) {
          var latLng = new google.maps.LatLng(stops[i].lat, stops[i].lon);
          var marker = new google.maps.Marker({
            position: latLng,
            map: map,
            title: stops[i].name
          });
        }
    }
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCgUYlm-BQOCLSc66tIMVe3DUSXwxpAjDw&callback=initMap">
</script>
