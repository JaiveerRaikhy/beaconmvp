'use client'

import { useState, useEffect } from 'react'

/**
 * Hook to fetch and cache a CSRF token for use in API requests.
 * The token is stored in an HttpOnly cookie by the server;
 * this hook retrieves the value to include in request headers.
 */
export function useCsrf() {
  const [token, setToken] = useState<string | null>(null)

  useEffect(() => {
    async function fetchToken() {
      try {
        const res = await fetch('/api/csrf')
        if (res.ok) {
          const data = await res.json()
          setToken(data.token)
        }
      } catch {
        // CSRF token fetch failed - requests will be rejected by server
      }
    }

    fetchToken()
  }, [])

  return token
}
