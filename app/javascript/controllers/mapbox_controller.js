import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import * as turf from "@turf/turf"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    messageCoordinates: Array,
    userCoordinates: Array
  }

  static targets = ["duration", "distance"];

  connect() {

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl }))
    if (this.userCoordinatesValue.length != 0) {
      const bounds = [
        this.messageCoordinatesValue,
        this.userCoordinatesValue
      ];

      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })

      const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${this.userCoordinatesValue[0]},${this.userCoordinatesValue[1]};${this.messageCoordinatesValue[0]},${this.messageCoordinatesValue[1]}?steps=true&geometries=geojson&access_token=${this.apiKeyValue}`;

      fetch(url)
        .then(response => response.json())
        .then((json) => {
          const data = json.routes[0];
          const route = data.geometry.coordinates;

          const geojson = {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: route
            }
          };

          this.map.addLayer({
            id: 'route',
            type: 'line',
            source: {
              type: 'geojson',
              data: geojson
            },
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': '#5591F5',
              'line-width': 5,
              'line-opacity': 0.75,
              'line-dasharray': [0, 2]
            }
          });


          this.durationTarget.innerHTML = `${Math.round(data.duration / 60)} min`;
          this.distanceTarget.innerHTML = `${(data.distance / 1000).toFixed(1)} km`;




          // Calculate the distance in kilometers between route start/end point.
          //const lineDistance = turf.length(route);
          // calculer distance entre coord du message et coord du user
          var line = turf.lineString(route);
          var length = turf.length(line, {units: 'miles'})*(1.60934*1000);
          console.log(length)
          const Swal = require('sweetalert2')


          // si la distance fait moins de m, alors je viens déclencher une modale
          if (length < 800) {
            console.log(Swal.fire("You're in ! Open up your Poner"));
          }




        })
    }
  }

  #addMarkersToMap() {

    this.markersValue.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window) // add this
      // const customMarker = document.createElement("div")
      // customMarker.className = "marker"
      // //customMarker.style.backgroundImage = `url('${marker.image_url}')`
      // customMarker.style.backgroundSize = "contain"
      // customMarker.style.width = "25px"
      // customMarker.style.height = "25px"

      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.html.trim();
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  };

};
