import { test, expect } from '@playwright/test'

test.describe('Authentication Flow', () => {
  test.describe('Signup', () => {
    test('should show signup page with all fields', async ({ page }) => {
      await page.goto('/signup')
      await page.waitForLoadState('networkidle')
      
      await expect(page.locator('#signup-fullName')).toBeVisible()
      await expect(page.locator('#signup-email')).toBeVisible()
      await expect(page.locator('#signup-password')).toBeVisible()
      await expect(page.locator('[data-testid="signup-submit"]')).toBeVisible()
    })

    test('should show validation errors for empty form submission', async ({ page }) => {
      await page.goto('/signup')
      await page.waitForLoadState('networkidle')
      
      await page.locator('[data-testid="signup-submit"]').click()
      await expect(page.getByText('Full name is required')).toBeVisible()
      await expect(page.getByText('Email is required')).toBeVisible()
      await expect(page.getByText('Password is required')).toBeVisible()
    })

    test('should show password length validation', async ({ page }) => {
      await page.goto('/signup')
      await page.waitForLoadState('networkidle')
      
      await page.locator('#signup-fullName').fill('Test User')
      await page.locator('#signup-email').fill('test@example.com')
      await page.locator('#signup-password').fill('12345')
      await page.locator('[data-testid="signup-submit"]').click()
      await expect(page.getByText('Password must be at least 6 characters')).toBeVisible()
    })
  })

  test.describe('Login', () => {
    test('should show login page with all fields', async ({ page }) => {
      await page.goto('/login')
      await page.waitForLoadState('networkidle')
      
      await expect(page.locator('#login-email')).toBeVisible()
      await expect(page.locator('#login-password')).toBeVisible()
      await expect(page.locator('[data-testid="login-submit"]')).toBeVisible()
    })

    test('should show validation errors for empty form', async ({ page }) => {
      await page.goto('/login')
      await page.waitForLoadState('networkidle')
      
      await page.locator('[data-testid="login-submit"]').click()
      await expect(page.getByText('Email is required')).toBeVisible()
      await expect(page.getByText('Password is required')).toBeVisible()
    })

    test('should show invalid email error', async ({ page }) => {
      await page.goto('/login')
      await page.waitForLoadState('networkidle')
      
      await page.locator('#login-email').fill('not-an-email')
      await page.locator('#login-password').fill('password123')
      await page.locator('[data-testid="login-submit"]').click()
      await expect(page.getByText('Please enter a valid email address')).toBeVisible()
    })

    test('should clear errors when user starts typing', async ({ page }) => {
      await page.goto('/login')
      await page.waitForLoadState('networkidle')
      
      await page.locator('[data-testid="login-submit"]').click()
      await expect(page.getByText('Email is required')).toBeVisible()

      await page.locator('#login-email').fill('a')
      await expect(page.getByText('Email is required')).not.toBeVisible()
    })
  })

  test.describe('Navigation', () => {
    test('should have link to signup from login page', async ({ page }) => {
      await page.goto('/login')
      await page.waitForLoadState('networkidle')
      
      const signupLink = page.locator('a[href="/signup"]')
      await expect(signupLink).toBeVisible()
    })

    test('should have link to login from signup page', async ({ page }) => {
      await page.goto('/signup')
      await page.waitForLoadState('networkidle')
      
      const loginLink = page.locator('a[href="/login"]')
      await expect(loginLink).toBeVisible()
    })
  })
})
