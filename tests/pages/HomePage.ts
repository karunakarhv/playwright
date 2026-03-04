import { Page, Locator } from "@playwright/test";

export class HomePage {
  readonly page: Page;
  readonly getStartedLink: Locator;

  constructor(page: Page) {
    this.page = page;
    this.getStartedLink = page.getByRole("link", { name: "Get started" });
  }

  async goto() {
    await this.page.goto(process.env.BASE_URL || "https://playwright.dev/");
  }

  async clickGetStarted() {
    await this.getStartedLink.click();
  }

  async getTitle() {
    return this.page.title();
  }

  heading(name: string) {
    return this.page.getByRole("heading", { name });
  }
}
