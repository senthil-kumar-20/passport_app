/**
 * 
 */

	var dtToday = new Date();
	var month = dtToday.getMonth() + 1;
	var day = dtToday.getDate();
	var year = dtToday.getUTCFullYear();
	if(month < 10)
	month = '0' + month.toString();
	if(day < 10)
	day = '0' + day.toString();
	var maxDate = year + '-' + month + '-' + day;
	document.getElementById("dob").setAttribute("max", maxDate);