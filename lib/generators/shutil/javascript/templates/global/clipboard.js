export default {
  load() {
    const clipboard = new Clipboard('.clipboard-btn');

    clipboard.on('success', (e) => {
      $(e.trigger).effect('highlight', {color: '#5cb85c'}, 2500)
    });
  },
};
