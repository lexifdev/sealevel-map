<sealevel-details>

    <div class="sealevel__details">

      <div class="sealevel__details__close" onclick="{ opts.oncloseclick }">&#10006;</div>

      <h1 class="sealevel__details__titel">{ opts.station.Location }</h1>

      <p>{ opts.station.Country }</p>

      <h4>Trend of Sea Level (1961-2011)</h4>

      <p>{ rise } { Math.abs(opts.station.trend) } mm per year</p>

      <sealevel-linechart chartdata="{ this.opts.station.tideData }"></sealevel-linechart>

      <h4>Additional Information on { opts.station.Country }</h4>

      <p>CO2 emissions: <b>{ opts.station.emission.toFixed(2) } tons per capita</b></p>

      <p>GDP: <b>{ (opts.station.gdp / 1000000000).toLocaleString('en-US', { maximumSignificantDigits: 3 }) } bn US Dollars</b></p>

      <p>Population: <b>{ (opts.station.pop).toLocaleString('en-US', { maximumSignificantDigits: 3 }) }</b></p>

      <p>People living in coastal areas: <b>{ opts.station.pop_sealevel.toFixed(1) } % of population</b></p>

    </div>

    <script type="text/babel">
      this.on('update', () => {
        if (this.opts.station) {
          const getYear = new Date(this.opts.station.tideData[0].timestamp)
          const currentYear = getYear.getFullYear()

          this.update({
            year: currentYear
          })

          this.rise = opts.station.trend > 0 ? 'Rise of ' : 'Fall of '
        }
      })
    </script>


</sealevel-details>
