console.log("Bun is ok.");

import { chromium } from "playwright";

console.log("Playwright is ok.");

await using browser = await chromium.launch({
  headless: true,
  chromiumSandbox: true,
});

console.log("Chromium is ok.");
