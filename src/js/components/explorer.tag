<sealevel-explorer>

  <sealevel-explorer-overview
    if={ !state.station }
    on-continent-select={ routes.routeToContinent }
    data={ state.state }
  />

  <sealevel-explorer-continent
    if={ state.continent }
    continent={ state.continent }
    countries={ countriesForContinent(state.continent) }
    path-to-country={ routes.country }
  />

  <sealevel-explorer-country
    if={ state.country }
    country={ state.country }
    stations={ stationsForCountry(state.country) }
    path-to-station={ routes.station }
  />

  <sealevel-explorer-details
    if={ state.station }
    station={ state.station }
    path-to-country={ routes.country }
  />

  <script type="text/babel">
    import _ from 'lodash'
    import route from 'riot-route'
    import * as routes from '../routes/'
    import { fetchAnimationDataIfNeeded } from '../actions/animation'
    import { requestStationDetails, requestStationList } from '../actions/explorer'
    import { setStep } from '../actions/navigation'

    const CONTINENTS = {
      'africa': 'Africa',
      'north-america': 'North America',
      'south-america': 'South America',
      'asia': 'Asia',
      'europe': 'Europe',
      'oceania': 'Oceania'
    }

    this.routes = routes
    this.state = this.store.getState().explorer

    route('explore/stations/*', id => {
      this.dispatch(requestStationDetails(id))
      this.dispatch(setStep('explore'))
    })

    route('explore/countries/*', id => {
      this.dispatch(requestStationList({ country: id }))
    })

    route('explore/*', id => {
      this.dispatch(requestStationList({ continent: id }))
    })

    route.exec()

    this.countriesForContinent = id => (
      _(this.state.items)
        .filter(station => station.continent === CONTINENTS[id])
        .map('country')
        .uniq()
        .sort()
        .value()
    )

    this.stationsForCountry = id => (
      _(this.state.items)
        .filter(station => station.country === id)
        .sortBy('location')
        .value()
    )

    this.on('route', () => {
      // Subscribe to global redux state:
      this.subscribe(({ explorer }) => {
        this.update({ state: explorer })
      })

      // Fetch data:
      this.dispatch(fetchAnimationDataIfNeeded())
    })

  </script>

</sealevel-explorer>
