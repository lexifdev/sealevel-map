<sealevel-scrolly>

  <sealevel-scrolly-intro active={introActive} />

  <article ref="article" />

  <script type="text/babel">
    import route from 'riot-route'
    import _ from 'lodash'
    import './scrolly-intro.tag'
    import { STEPS } from '../../routes/'
    import { setStep } from '../../actions/navigation'
    import content from '../../../en.md'

    this.on('mount', () => {
      this.refs.article.innerHTML = content
    })

    // initialize routes for main navigation:
    _.forEach(STEPS, slug => {
      route(slug, () => {
        console.log('show step', slug)
        this.store.dispatch(setStep(slug))
        this.update({ introActive: false })
      })
    })

    route('/', () => {
      this.update({ introActive: true })
    })

    route.exec()

  </script>

</sealevel-scrolly>
