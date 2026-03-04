import { test, expect } from "@playwright/test";
import { HomePage } from "./pages/HomePage";

test("has title", async ({ page }) => {
  const home = new HomePage(page);

  await home.goto();
  // Expect a title "to contain" a substring.
  await expect(await home.getTitle()).toContain("Playwright");
});

test("get started link", async ({ page }) => {
  const home = new HomePage(page);

  await home.goto();
  // Click the get started link.
  await home.clickGetStarted();
  // Expects page to have a heading with the name of Installation.
  await expect(home.heading("Installation")).toBeVisible();
});
