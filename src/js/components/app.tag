<sealevel-app>

  <sealevel-map
    onmarkerclick={ routeToStationDetails }
    center={ center }
    active={ state.navigation.activeStep }
    animationdata={ state.animation.items }
    options={ opts }
    steps={ steps }
  />

  <sealevel-navigation
    steps={ steps }
    active={ activeStep }
  />

  <sealevel-explorer
    state={ state.explorer }
    onselect={ routeToStationList }
    route-to-continent={ routeToContinent }
  />

  <script type="text/babel">
    import route from 'riot-route'
    import { setStep } from '../actions/navigation'
    import { fetchAnimationDataIfNeeded } from '../actions/animation'
    import {
      requestStationDetails,
      hideStationDetails,
      requestStationList
    } from '../actions/explorer'

    const store = this.opts.store

    this.on('mount', () => {
      store.dispatch(fetchAnimationDataIfNeeded())
    })

    store.subscribe(() => {
      this.update({ state: store.getState() })
    })

    this.steps = [
      '',
      'experimental-animation-1',
      'experimental-animation-2'
    ]

    this.routeToStation = (id) => {
      route(`stations/${id}`)
    }

    this.routeToCountry = (id) => {
      route(`countries/${id}`)
    }

    this.routeToContinent = (id) => {
      route(`continents/${id}`)
    }

    this.routeToStationOverview = () => {
      route('stations')
    }

    route(slug => {
      const activeStep = this.steps.indexOf(slug)
      if (activeStep >= 0) {
        store.dispatch(setStep(activeStep))
      }
    })

    route('stations', () => {
      store.dispatch(hideStationDetails())
    })

    route('stations/*', id => {
      store.dispatch(requestStationDetails(id))
    })

    route('countries', () => {
      store.dispatch(requestStationList())
    })

    route('countries/*', id => {
      store.dispatch(requestStationList({ country: id }))
    })

    route('continents/*', id => {
      store.dispatch(requestStationList({ continent: id }))
    })

    route.start(true)
  </script>
</sealevel-app>
