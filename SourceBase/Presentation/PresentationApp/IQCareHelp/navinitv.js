/*!
Navigation pane init functions for Premium Pack Version 1.54 for Help & Manual 6
Copyright (c) 2008-2011 by Tim Green.
All rights reserved. 
*/
function addEvent(e,d,b,a){if(e.addEventListener){e.addEventListener(d,b,a);return true}else{if(e.attachEvent){var c=e.attachEvent("on"+d,b);return c}else{alert("Could not add event!")}}}function headResizeTOC(){var a=document.getElementById("ns-title").offsetHeight;a=a+"px";document.getElementById("body-shift").style.paddingTop=a}function headResizeIDX(){var b=document.getElementById("ns-title").offsetHeight;var a=b+30;a=a+"px";b=b+"px";document.getElementById("body-shift").style.paddingTop=b;document.getElementById("scrollPadder").style.height=a}function headResizeSCH(){var a=document.getElementById("ns-title").offsetHeight;a=a+"px";document.getElementById("body-shift").style.paddingTop=a};