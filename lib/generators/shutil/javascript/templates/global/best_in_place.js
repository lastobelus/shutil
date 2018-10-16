export default {
  load() {
    console.log('initializing best_in_place', $('.best_in_place'));
    $('.best_in_place').best_in_place();
    $('.best_in_place').bind('ajax:success', function _highlightBestInPlaceSuccess() {
      $(this).closest('td').effect('highlight', { color: '#5cb85c' }, 2500);
    });
  },
};
