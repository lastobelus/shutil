export default {
  init() {
    $(document).on('change', ':file', function () {
      console.log('file change event');
      const input = $(this); const numFiles = input.get(0).files ? input.get(0).files.length : 1; const
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
      input.trigger('fileselect', [
        numFiles,
        label,
      ]);
    });

    $(document).on('fileselect', ':file', function (event, numFiles, label) {
      console.log('fileselect event');
      const input = $(this).parents('.input-group').find(':text'); const
        log = numFiles > 1 ? `${numFiles } files selected` : label;
      if (input.length) {
        input.val(log);
      } else if (log) {alert(log)};
    });
  },
};
