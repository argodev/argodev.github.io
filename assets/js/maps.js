var encoded_route = "en`zEzc~`OhcRxeX~qo@hcm@zlj@zhi@";

var routePath = new google.maps.Polyline({
          path: google.maps.geometry.encoding.decodePath(encoded_route),
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 4
        });

        routePath.setMap(map);