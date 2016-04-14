$(function () {
  var selectc = document.getElementById("selectc");
  if(selectc != null){
    selectc.addEventListener("change", function(){
      if(selectc.value == 0){
        document.getElementById("addc").innerHTML = "<input type='text' class='form-control col-xs-3' name='addc' autofocus placeholder='Add Here'>";
      }else{
        document.getElementById("addc").innerHTML = "";
      }
    });
  }
});
