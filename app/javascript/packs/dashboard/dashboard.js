

window.openNav = function() {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

window.closeNav = function() {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
}


function changeStar() {
    var emptystar = 5 - this.value;
    var block = document.querySelectorAll('.fa-star');

    // case: click 5 -> fulfill all
    if(emptystar == 0){
        for (let index = 0; index < 5; index++) {
            block[index].classList.replace('fa-regular','fa-solid');
        }
    }
    else{
         // case: first click 1 - 4 star
        // first loop to fulfill 
        for (let index = 0; index < this.value; index++) {
            block[index].classList.replace('fa-regular','fa-solid');
        }
        // second loop to empty
        for (let index = this.value ; index < 5; index++) {
            block[index].classList.replace('fa-solid','fa-regular');
        }
    }
}

window.selectRating = function() {
  console.log("heheeh");
  var select = document.querySelector("#review_rating");
  select.addEventListener('change', changeStar, false);
}
