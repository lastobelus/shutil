export default {
  load() {
    console.log('initializing disabled links');
    $('a[disabled=disabled]').click((event) => {
      event.preventDefault(); // Prevent link from following its href
    });
  },
}
;