window.onload = function changeBgGrad() {
  var bgGradCount = 4;
  var bgGradPref = "bg-grad";
  var bgGradNum = Math.floor(Math.random() * bgGradCount);
  var body = document.getElementsByTagName('body')[0];
  body.className = bgGradPref + bgGradNum;
}
