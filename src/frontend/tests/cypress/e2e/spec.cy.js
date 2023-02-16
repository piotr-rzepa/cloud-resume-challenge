/*jshint esversion: 8 */

const { expect } = require("chai");

const RESUME_URL_CLOUDFRONT = "d124b0ft49cngv.cloudfront.net";

const API_GATEWAY_URL =
  "https://lclqrodef7.execute-api.eu-west-1.amazonaws.com/prod/visitors";

describe("template spec", () => {
  it("should open a resume page", () => {
    cy.visit(RESUME_URL_CLOUDFRONT);
  });

  it("should click a link to email", () => {
    cy.visit(RESUME_URL_CLOUDFRONT);
    cy.contains("piotr.rzepkowski98@gmail.com");
  });

  it("should click a link to Linkedin", () => {
    cy.visit(RESUME_URL_CLOUDFRONT);
    cy.contains("linkedin.com/in/piotr-rzepkowski");
  });

  it("should click a link to GitHub", () => {
    cy.visit(RESUME_URL_CLOUDFRONT);
    cy.contains("github.com/piotr-rzepa");
  });

  it("should send a valid POST request", () => {
    cy.visit(RESUME_URL_CLOUDFRONT);
    cy.request("POST", API_GATEWAY_URL, {
      headers: { "Content-Type": "application/json" },
    }).then((response) => {
      expect(response.status).to.eq(200);
      expect(response.body.visits).to.be.a("number");
    });
  });

  it("should increment visitors counter on visit by 1", () => {
    let visitorsCounter;
    let updatedVisitorsCounter;
    cy.visit(RESUME_URL_CLOUDFRONT);
    cy.wait(1000);
    cy.contains("This page has been visited")
      .invoke("text")
      .then((text) => {
        visitorsCounter = text.replace(/[^0-9]/g, "");
      });
    cy.reload();
    cy.wait(1000);
    cy.contains("This page has been visited")
      .invoke("text")
      .then((text) => {
        updatedVisitorsCounter = text.replace(/[^0-9]/g, "");
        expect(parseInt(updatedVisitorsCounter)).to.be.greaterThan(
          parseInt(visitorsCounter)
        );
        expect(parseInt(updatedVisitorsCounter)).to.be.equal(
          parseInt(visitorsCounter) + 1
        );
      });
  });
});
