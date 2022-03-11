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

    this.#addGeolocationControl();
    this.#addMarkersToMap();

    if (this.userCoordinatesValue.length === 0) {
      this.#fitMapToMarkers();
    }

    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl }))

    if (this.userCoordinatesValue.length != 0) {
      this.#fitMapToItinerary();

      this.map.on('load', this.onLoad.bind(this));
    }
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  onLoad() {
    this.geolocate.trigger();
  }

  #addGeolocationControl() {
    // Add geolocate control to the map.
    this.geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true
    });

    this.map.addControl(this.geolocate);

    this.geolocate.on('geolocate', (e) => {
      // console.log('user geolocated.');
      // console.log(e.coords.latitude)
      // console.log(e.coords.longitude)

      if (this.userCoordinatesValue.length != 0) {
        this.userCoordinatesValue = [e.coords.longitude, e.coords.latitude];

        this.#addItinerary();
        this.#fitMapToItinerary();
      }
    });
  }



  #addItinerary() {
    if (this.itineraryLoaded == true) { return }

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
        // Calculate the distance in kilometers between route start/end point.
        //const lineDistance = turf.length(route);

        // calculer distance entre coord du message et coord du userr
        const line = turf.lineString(route);
        const distance = turf.length(line, {units: 'kilometers'})*1000;
        console.log(distance)

        // si la distance fait moins de m, alors je viens déclencher une modale
        if (distance < 500) {
          setTimeout(() => {
            const url = `/message_users/${this.messageUserIdValue}/access_to_message`
            fetch(url, { headers: { "Accept": "text/plain" } })
              .then(response => response.text())
              .then((data) => {
                Swal.fire({
                  html: data,
                  showConfirmButton: false,
                  customClass: {
                    container: 'swalpopup'
                  }
                });
              })
            ;
          }, 5000);
        }

        this.itineraryLoaded = true;

        this.durationTarget.innerHTML = `${Math.round(data.duration / 60)} min`;
        this.distanceTarget.innerHTML = `${(data.distance / 1000).toFixed(1)} km`;

        // Calculate the distance in kilometers between route start/end point.
        //const lineDistance = turf.length(route);
      })
  }

  #getCurrentPosition(){
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    function success(pos) {
      var crd = pos.coords;

      console.log('Your current position is:');
      console.log(`Latitude : ${crd.latitude}`);
      console.log(`Longitude: ${crd.longitude}`);
      console.log(`More or less ${crd.accuracy} meters.`);
    }

    function error(err) {
      console.warn(`ERROR(${err.code}): ${err.message}`);
    }

    navigator.geolocation.getCurrentPosition(success, error, options);
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

      const popup = new mapboxgl.Popup({maxWidth:'95%', anchor: 'top-left', className: "poner-popup"}).setHTML(marker.info_window)
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToItinerary() {
    const bounds = [
      this.messageCoordinatesValue,
      this.userCoordinatesValue
    ];

    this.map.fitBounds(bounds, { padding: 80, maxZoom: 20, duration: 0 });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 80, maxZoom: 15, duration: 0 })
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
