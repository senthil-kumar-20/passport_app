function callvalue(event){
    event.preventDefault();

    var userId=document.getElementById("userId").value;
    var country=document.getElementById("country").value;
    var occupation=document.getElementById("occupation").value;
    var dateOfApplication=document.getElementById("dateOfApplication").value;

    var visaId = generateVisaId(occupation);
    var dateOfIssue = calculateIssueDate();
    var dateOfExpiry = calculateExpiryDate(dateOfIssue, occupation);
    var registrationCost = calculateRegistrationCost(country, occupation);

    document.writeln("<p>Dear User, your Visa request has been accepted successfully with ID: " + visaId + "</p>"+
    "<p>User ID: " + userId + "</p>"+
    "<p>Destination: " + country + "</p>"+
    "<p>Employee Occupation: " + occupation + "</p>"+
    "<p>Date of Application: " + dateOfApplication + "</p>"+
    "<p>Date of Issue: " + dateOfIssue + "</p>"+
    "<p>Date of Expiry: " + dateOfExpiry + "</p>"+
    "<p>Registration Cost: " + registrationCost + "</p>");


    document.getElementById("userId").value = "";
    document.getElementById("country").value = "";
    document.getElementById("occupation").value = "";
    document.getElementById("dateOfApplication").value = "";

    // Add event listener to the form to prevent submission
    document.getElementById("visaForm").addEventListener("submit", function(event) {
      event.preventDefault(); // Prevent form submission
    });
    // Append the message element to the message container
    document.getElementById("visaForm").appendChild(messageElement);

    


}
document.addEventListener("DOMContentLoaded", function() {
    var dateField = document.getElementById('dateOfApplication');
    var currentDate = new Date().toISOString().split('T')[0];
    dateField.value = currentDate;
  });
  function generateVisaId(occupation) {
    var visaId = '';
  
    if (occupation === 'Student') {
      visaId += 'STU';
    } else if (occupation === 'Private Employee') {
      visaId += 'PE';
    } else if (occupation === 'Government Employee') {
      visaId += 'GE';
    } else if (occupation === 'Self Employed') {
      visaId += 'SE';
    } else if (occupation === 'Retire Employee') {
      visaId += 'RE';
    }
  
    return visaId + '-' + Math.floor(Math.random() * 10000);
  }
  
  /*function getCurrentDate() {
    var currentDate = new Date().toISOString().split('T')[0];
    return currentDate;
  }*/
  
  function calculateIssueDate() {
    var expiryDate = new Date();
    expiryDate.setDate(expiryDate.getDate() + 10); // Adding 10 days to the current date
    return expiryDate.toISOString().split('T')[0];
  }
  
  function calculateExpiryDate(dateOfIssue, occupation) {
    var expiryPeriod;
  
    switch (occupation) {
      case 'Student':
        expiryPeriod = 2;
        break;
      case 'Private Employee':
        expiryPeriod = 3;
        break;
      case 'Government Employee':
        expiryPeriod = 4;
        break;
      case 'Self Employed':
        expiryPeriod = 1;
        break;
      case 'Retire Employee':
        expiryPeriod = 1.5;
        break;
      default:
        expiryPeriod = 0; // Default expiry period is 0 for unknown occupations
        break;
    }
  
    var expiryDate = new Date(dateOfIssue);
    expiryDate.setFullYear(expiryDate.getFullYear() + Math.floor(expiryPeriod));
    expiryDate.setMonth(expiryDate.getMonth() + Math.round((expiryPeriod % 1) * 12));
    return expiryDate.toISOString().split('T')[0];
  }
  
  function calculateRegistrationCost(country, occupation) {
    // Define a map of registration costs by place and occupation
    const registrationCosts = new Map([
      ['USA', new Map([
        ['Student', 3000],
        ['Private Employee', 4500],
        ['Government Employee', 5000],
        ['Self Employed', 6000],
        ['Retire Employee', 2000]
      ])],
      ['CHINA', new Map([
        ['Student', 1500],
        ['Private Employee', 2000],
        ['Government Employee', 3000],
        ['Self Employed', 4000],
        ['Retire Employee', 2000]
      ])],
      ['JAPAN', new Map([
        ['Student', 3500],
        ['Private Employee', 4000],
        ['Government Employee', 4500],
        ['Self Employed', 9000],
        ['Retire Employee', 1000]
      ])]
    ]);
  
    // Get the registration cost based on the selected country and occupation
    const registrationCost = registrationCosts.get(country).get(occupation);
  
    return '$' + registrationCost;
  }
 