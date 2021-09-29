Dropzone.autoDiscover = false;

$(document).ready(() => {
  $('.upload-images').dropzone({
    addRemoveLinks: true,
    maxFilesize: 1,
    autoProcessQueue: false,
    uploadMultiple: true,
    parallelUploads: 10,
    maxFiles: 10,
    paramName: 'images',
    previewsContainer: '.dropzone-previews',
    clickable: '.upload-photos-icon',
    thumbnailWidth: 100,
    thumbnailHeight: 100,

    init: () => {
      var myDropzone = this;

      this.element.querySelector("input[type=submit]").addEventListener('click', (e) => {
        console.log(e)
        e.preventDefault();
        e.stopPropagation();
        myDropzone.processQueue();
      });

      this.on('successmultiple', (files, response) => {
        window.location.reload();
      });

      this.on('errormultiple', (files, response) => {
        toastr.error(response);
      });
    }
  })
});
