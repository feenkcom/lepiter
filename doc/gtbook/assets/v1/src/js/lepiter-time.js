// Code common for individual published pages and index pages

function updateTimeDistances() {
    var allElements = document.querySelectorAll('span[lepiter-publish-time]');
    allElements.forEach(function(currentElement, currentIndex, listObj) {
      var aDistance = dateFns.distanceInWordsToNow(
        new Date(Number(currentElement.getAttribute('lepiter-publish-time'))), 
        { addSuffix: true });
      currentElement.innerHTML = aDistance; } ) };
  
async function onDOMContentLoaded() {
  updateTimeDistances();
  setInterval(updateTimeDistances, 60000);
}
  
document.addEventListener("DOMContentLoaded", onDOMContentLoaded);
