/*jshint esversion: 8 */

const p = document.querySelector("#visit-counter");
VISITORS_ENDPOINT =
  "https://lclqrodef7.execute-api.eu-west-1.amazonaws.com/prod/visitors";

const updateCounter = async (event) => {
  const response = await fetch(VISITORS_ENDPOINT, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  });
  const visitors = await response.json();
  p.textContent = `This page has been visited ${visitors.visits} times`;
};

window.addEventListener("DOMContentLoaded", updateCounter);
