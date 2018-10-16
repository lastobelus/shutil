const vendorFulfillmentStatusHandler = {
  handle(data){
    console.log("vendorFulfillmentStatusHandler.handle", data)
    const {at, checked, error_details, finished, state, vendor, vendor_fulfillment_id, vendor_reference, css} = data
    const $stateElm = $(`[data-vendor-fulfillment-id="${vendor_fulfillment_id}"]`)
    const spinner = $stateElm.find('.spinner')
    const displays = $stateElm.data('displays')
    $stateElm.find('.state').text(state)
    $stateElm.find('.vendor').text(vendor)
    $stateElm.removeClass()
    $stateElm.addClass(css)
    $stateElm.addClass("vendor-fulfillment-state-btn")
    spinner.toggleClass('fa-refresh', finished )
    spinner.toggleClass('fa-spinner', !finished )
    spinner.toggleClass('fa-pulse', !finished )
    let title = `<strong>id</strong> ${vendor_fulfillment_id}<br>`
    if( at ) {
      title = title + `<strong>at</strong> ${at}`
    }
    if ((title.length > 0) && checked) {
      title = title + "<br>"
    }
    if( checked ) {
      title = title + `<strong>checked</strong> ${checked}`
    }

    $stateElm.attr('data-original-title', title)
  }
}

export default {
  init(app) {
    app.vendorFulfillmentStatusHandler = vendorFulfillmentStatusHandler

    $(document).on('click', '.vendor-fulfillment-state-btn', function() {
      const $this = $(this)
      const id = $this.data('vendor-fulfillment-id')
      console.log('id: ', id);
      const spinner = $this.find('.spinner')
      if( spinner.hasClass('fa-refresh') ) {
        spinner.removeClass('fa-refresh')
        spinner.addClass('fa-spinner')
        spinner.addClass('fa-pulse')
        app.fulfillmentChannel.updateVendorStatus({vendor_fulfillment_id: id})
      }

    })
  },

  load() {
  }

}
