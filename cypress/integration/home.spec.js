describe('Visit Home Page', () => {
  it("should visit app homepage", () => {
    cy.visit('/')
  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});