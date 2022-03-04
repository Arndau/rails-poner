import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import * as turf from "@turf/turf"
import Swal from 'sweetalert2'

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    messageCoordinates: Array,
    userCoordinates: Array,
    messageUserId: Number
  }

  static targets = ["duration", "distance"];

  connect() {

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

        // Add geolocate control to the map.
    this.map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true
      })
      );

    if (this.userCoordinatesValue.length === 0) {
      this.#addMarkersToMap();
      this.#fitMapToMarkers();
    }


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
          const line = turf.lineString(route);
          const distance = turf.length(line, {units: 'kilometers'})*1000;
          console.log(distance)   



          // si la distance fait moins de m, alors je viens déclencher une modale
          if (distance < 2000) {
            const url = `/message_users/${this.messageUserIdValue}/access_to_message`
            fetch(url, { headers: { "Accept": "text/plain" } })
              .then(response => response.text())
              .then((data) => {
                Swal.fire({
                  html: data,
                  showConfirmButton: false
                });
               })
             
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
      const popupOffsets = {
        'top': [-170, 0],
        'top-left': [0, 0],
        'top-right': [0, 0],
        'bottom': [0, 0]
      };
      const popup = new mapboxgl.Popup({offset: popupOffsets,className: "poner-popup"}).setHTML(marker.info_window)
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

//OK
// 1. Créer l'action access_to_message dans message_users controller (et la route qui va avec)
// 2. Créer la vue qui va avec (avec le link_to)

// A FAIRE
// 3. Récupérer dans mon JS, l'id du @message_user pour construire l'url vers l'action access_to_message
// 4. Fetch cette url (method: GET)
// 5. Je dois renvoyer avec l'action access_to_message une partial de la vue créé en point (2) en format text
// 6. Je la récupère dans mon JS et je l'affecte à l'option html de mon SWAL
