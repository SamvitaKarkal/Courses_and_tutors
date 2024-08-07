
document.addEventListener("DOMContentLoaded", () => {
  const tutorFieldsTemplate = document.getElementById("tutor-fields-template").innerHTML;
  let tutorIndex = document.querySelectorAll(".nested-fields").length;
  
  document.getElementById("add-tutor").addEventListener("click", (e) => {
    e.preventDefault();
    addTutorFields();
  });

  function addTutorFields() {
    const newFields = tutorFieldsTemplate.replace(/INDEX/g, tutorIndex);
    document.getElementById("tutors").insertAdjacentHTML("beforeend", newFields);
    tutorIndex++;
  }

  document.getElementById("tutors").addEventListener("click", (e) => {
    if (e.target.classList.contains("remove-tutor")) {
      e.preventDefault();
      e.target.closest(".nested-fields").remove();
    }
  });
});