<sealevel-app>

  <sealevel-map
    routes={ routes }
    center={ center }
    state={ state }
    options={ opts }
  />

  <sealevel-navigation
    active={ state.navigation.activeStep }
    steps={ routes.STEPS }
  />

  <sealevel-explorer
    state={ state.explorer }
    routes={ routes }
  />

  <script type="text/babel">
    import { fetchAnimationDataIfNeeded } from '../actions/animation'
    import * as routes from '../routes/'

    const store = this.opts.store

    this.on('mount', () => {
      this.routes = routes
      routes.startRouting(store)
      store.dispatch(fetchAnimationDataIfNeeded())
    })

    store.subscribe(() => {
      this.update({ state: store.getState() })
    })
  </script>
</sealevel-app>
