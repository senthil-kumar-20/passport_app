/**
 * 
 */
const form = document.getElementById("registrationForm");

// Add event listener for form submission
form.addEventListener("submit", function (e) {
  e.preventDefault(); // Prevent default form submission

  // Get the form inputs
  const firstName = document.getElementById("firstName").value;
  const lastName = document.getElementById("lastName").value;
  const dob = document.getElementById("dob").value;
  const address = document.getElementById("address").value;
  const contactNo = document.getElementById("contactNo").value;
  const email = document.getElementById("email").value;
  const qualification = document.getElementById("qualification").value;
  const gender = document.getElementById("gender").value;
  const applyType = document.getElementById("applyType").value;
  const password = document.getElementById("password").value;
  const hintQuestion = document.getElementById("hintQuestion").value;
  const hintAnswer = document.getElementById("hintAnswer").value;

  const citizenType = determineCitizenType(dob);
  document.getElementById("hidden").value = citizenType;
  console.log(citizenType);
});

function determineCitizenType(dob) {
  const currentDate = new Date();
  const dobDate = new Date(dob);
  const age = currentDate.getFullYear() - dobDate.getFullYear();
  let citizenType;
  if (age <= 1) {
    citizenType = "infant";
  } else if (age <= 10) {
    citizenType = "Children";
  } else if (age <= 20) {
    citizenType = "Teen";
  } else if (age <= 50) {
    citizenType = "Adult";
  } else {
    citizenType = "Senior Citizen";
  }
  return citizenType;
}