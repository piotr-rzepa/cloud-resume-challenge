/*jshint esversion: 8 */

const p = document.querySelector("#visit-counter");
VISITORS_ENDPOINT =
  "https://3q6c09cnfa.execute-api.eu-west-1.amazonaws.com/prod/visitors";

const updateCounter = async (event) => {
  const response = await fetch(VISITORS_ENDPOINT, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  });
  const visitors = await response.json();
  return visitors.visits;
};

window.addEventListener("DOMContentLoaded", updateCounter);
