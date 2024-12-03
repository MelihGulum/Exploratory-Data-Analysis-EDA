function validator(){
    if(!((document.querySelector("#image-upload").value =="") || (document.querySelector("#audio-upload").value =="" ))){
        alert('You can not load both image and audio');
        }
    else if(((document.querySelector("#image-upload").value =="") && (document.querySelector("#audio-upload").value =="" )))
        alert('You can not predict empty data');

}


