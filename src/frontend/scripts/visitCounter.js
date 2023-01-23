/*jshint esversion: 6 */

const p = document.querySelector("#visit-counter");

if (typeof Storage !== "undefined") {
  // Set the counter to 0 if user opens site for the first time
  if (localStorage.getItem("visits") === null) localStorage.visits = 0;
} else {
  console.error("This browser does not support Web Storage.");
}

const updateCounter = (event) => {
  const visits = Number.parseInt(localStorage.visits) + 1;
  localStorage.visits = visits;
  p.textContent = `This page has been visited ${visits} times`;
  console.log(p.textContent);
};

window.addEventListener("DOMContentLoaded", updateCounter);
