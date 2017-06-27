<sealevel-scrolly>

  <sealevel-scrolly-map />

  <sealevel-scrolly-intro locale={locale} />

  <article class="scrolly__article" id="article">

    <header class="scrolly__header">
      <h1 class="scrolly__title">
        { i18n.t('scrolly.title') }
      </h1>
      <p class="scrolly__lead">
        { i18n.t('scrolly.lead') }
      </p>
    </header>

    <sealevel-scrolly-content steps={ this.steps } />

  </article>

  <nav class="scrolly__nav" data-gumshoe-header>
    <ul data-gumshoe>
      <li each={ step in steps }>
        <a class="scrolly__nav__link" href="#{ step }">{ title }</a>
      </li>
    </ul>
  </nav>

  <script type="text/babel">
    import route from 'riot-route'
    import _ from 'lodash'
    import gumshoe from 'gumshoe'
    import './scrolly-intro.tag'
    import './scrolly-content.tag'
    import './scrolly-map.tag'
    import { setStep } from '../../actions/navigation'
    import { STEPS } from '../../routes/'

    const initNavigation = (language) => {
      _.defer(gumshoe.init, {
        container: window,
        activeClass: 'scrolly__nav__link--active',
        callback: (event) => {
          const active = event && event.target.id
          if (active) {
            route(`${language}/#${active}`)
          }
        }
      })
    }

    // Make steps available in template:
    this.steps = STEPS

    this.on('route', (language, anchor) => {
      this.i18n.setLocale(language)
      this.store.dispatch(setStep(anchor))
      initNavigation(language)
    })

  </script>

</sealevel-scrolly>
