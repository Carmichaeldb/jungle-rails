describe("product details test", () => {
  it("should visit app home page", () => {
    cy.visit("/");
  });

  it("Click on product and view product page", () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("exist");
  });
});
