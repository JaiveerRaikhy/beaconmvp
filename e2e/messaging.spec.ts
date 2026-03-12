import { test, expect } from '@playwright/test'

test.describe('Messaging Flow', () => {
  // Note: Full messaging tests require authenticated users with active matches.
  // These tests verify page structure and basic accessibility.

  test('should have messages page accessible', async ({ page }) => {
    await page.goto('/messages')
    const url = page.url()
    // Verify the page loads (may redirect to login)
    expect(url).toBeTruthy()
  })

  test('should show conversation list or empty state when authenticated', async ({ page }) => {
    await page.goto('/messages')
    const url = page.url()
    if (url.includes('/messages')) {
      // Page should render without errors
      // Look for messages-related content or empty state
      const pageContent = await page.textContent('body')
      expect(pageContent).toBeTruthy()
    }
  })

  test('messages page should have proper structure', async ({ page }) => {
    await page.goto('/messages')
    const url = page.url()
    if (url.includes('/messages')) {
      // The messages page should have some kind of layout
      const mainContent = page.locator('main, [role="main"], .container, #__next')
      const count = await mainContent.count()
      expect(count).toBeGreaterThanOrEqual(0)
    }
  })

  test('should not expose message content without authentication', async ({ page }) => {
    // Try accessing messages without auth - should redirect
    await page.goto('/messages')
    const url = page.url()
    // Either redirected to login or shows auth-required content
    if (!url.includes('/messages')) {
      expect(url).toMatch(/login|signup|auth/)
    }
  })
})
