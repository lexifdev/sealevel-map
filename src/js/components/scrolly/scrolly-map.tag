<sealevel-scrolly-map class="scrolly__map">

  <div id="scrolly__map" class="scrolly__map__container"></div>

  <sealevel-scrolly-map-animation
    if={state.animation.items && activeStep === 'world'}
    map={map} items={state.animation.items}
  />

  <sealevel-scrolly-map-visualization
    if={state.animation.items && activeStep !== 'world'}
    map={map} items={state.explorer.items}
  />

  <script type="text/babel">
    import mapboxgl from 'mapbox-gl'
    import { fetchAnimationDataIfNeeded } from '../../actions/animation'
    import { requestStationList } from '../../actions/explorer'
    import './scrolly-map-animation.tag'
    import './scrolly-map-visualization.tag'

    this.activeLayers = []
    this.state = this.store.getState()
    this.subscribe(state => this.update({ state }))

    this.on('update', () => {
      this.activeStep = this.state.navigation.activeStep
    })

    this.on('updated', () => {
      this.map && updateLayers(this.activeStep)
    })

    this.on('mount', () => {
      this.map = renderMap()
      this.store.dispatch(fetchAnimationDataIfNeeded())
      this.store.dispatch(requestStationList())
    })

    const updateLayers = (activeStep) => {
      switch (activeStep) {

        case 'world':
          this.map.fitBounds([
            [-160, -55],
            [185.1, 75]
          ], { duration: 0 })
          break

        case 'manila':
          this.map.flyTo({
            center: [121, 14.65],
            zoom: 9.5,
            offset: [-100, 0]
          })
          break

        case 'scandinavia':
          this.map.fitBounds([
            [-25.18, 54.47],
            [32.82, 71.27]
          ], {
            offset: [100, 0]
          })
          break

        case 'france':
          this.map.flyTo({
            center: [3.93, 43.52],
            zoom: 4,
            offset: [-100, 0]
          })
          break

        case 'usa':
          this.map.flyTo({
            center: [-73.93, 40.52],
            zoom: 5,
            offset: [150, 0]
          })
          break

        case 'argentina':
          this.map.flyTo({
            center: [-58.38, -34.6],
            zoom: 5,
            offset: [-100, 0]
          })
          break
      }
    }

    const renderMap = () => {
      mapboxgl.accessToken = 'pk.eyJ1IjoiY29ycmVjdGl2IiwiYSI6ImNpZXZoc2k3dzAwYjZ0cGtzZ3lzcWRxZ3oifQ.D7nZQDnSO4BMLssgleNSSg'

      const map = new mapboxgl.Map({
        container: 'scrolly__map',
        style: 'mapbox://styles/correctiv/cj5ck638406zq2rs1y0toq1ba',
        zoom: 3
      })

      map.on('load', () => {
        // disable map rotation using right click + drag
        map.dragRotate.disable()

        // disable map rotation using touch rotation gesture
        map.touchZoomRotate.disableRotation()

        // // initial state
        // updateLayers('world')
      })

      return map
    }

  </script>
</sealevel-scrolly-map>
