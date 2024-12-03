document.getElementById("audio-upload")
document.addEventListener("change", changeHandler);

function changeHandler({
  target
}) {
  // Make sure we have files to use
  if (!target.files.length) return;

  // Create a blob that we can use as an src for our audio element
  const urlObj = URL.createObjectURL(target.files[0]);

  // Create an audio element
  const audio = document.createElement("audio");

  // Clean up the URL Object after we are done with it
  audio.addEventListener("load", () => {
    URL.revokeObjectURL(urlObj);
  });

  // Append the audio element
  var newItem = document.createElement("LI");
  newItem.appendChild(audio);

  var list = document.getElementById("myList");
  list.insertBefore(newItem, list.childNodes[0]);

  // Allow us to control the audio
  audio.controls = "true";

  // Set the src and start loading the audio from the file
  audio.src = urlObj;
};