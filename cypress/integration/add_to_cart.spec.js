describe("Test add to cart", () => {
  it("should visit app homepage", () => {
    cy.visit("/");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Adds a product to the cart", () => {
    cy.get(".products article")
      .first()
      .find(".btn")
      .should("be.visible")
      .click({ force:true });
  })

  it("checks cart for item added", () => {
    cy.get(".nav-link").contains("My Cart (1)").should("be.visible");
  })
});
