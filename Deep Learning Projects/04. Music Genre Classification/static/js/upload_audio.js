const input = document.getElementById('audio-upload');
const link = document.getElementById('link');
let objectURL;

input.addEventListener('change', function () {
  if (objectURL) {
    // revoke the old object url to avoid using more memory than needed
    URL.revokeObjectURL(objectURL);
  }

  const file = this.files[0];
  objectURL = URL.createObjectURL(file);

  link.href = objectURL;
  var today = new Date();
  link.download=file.name
  link.click();


});