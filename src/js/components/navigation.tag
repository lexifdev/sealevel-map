<sealevel-navigation>

  <ul class="bullet-list">
    <li class="bullet-list__item" each="{ slug, i in this.opts.steps }">
      <a href="#{slug}" class="link {link--active: this.isActive(i)}">
        { slug }
      </a>
    </li>
  </ul>

  <script type="text/babel">
    this.isActive = (id) => {
      return this.opts.active === id
    }
  </script>

</sealevel-navigation>