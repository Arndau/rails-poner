import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    messageCoordinates: Array,
    userCoordinates: Array
  }

  static targets = ["duration", "distance"];

  connect() {
    // console.log("message", this.messageCoordinatesValue);
    // console.log("user", this.userCoordinatesValue);

    // console.log("duration", this.durationTarget);
    // console.log("distance", this.distanceTarget);

    // TODO: geocode user
    // this.userCoordinatesValue = .... -> [2.3853767, 48.8641418]

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

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

        // Instructions
        // console.log(data.distance)
        // console.log(data.duration)

        this.durationTarget.innerHTML = `${Math.round(data.duration / 60)} min`;
        this.distanceTarget.innerHTML = `${(data.distance / 1000).toFixed(1)} km`;
      })

    // this.#addMarkersToMap();
    // this.#fitMapToMarkers();
  }

  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .addTo(this.map)
  //   });
  // };

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  // };
};
