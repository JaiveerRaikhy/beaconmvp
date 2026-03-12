/**
 * Simple encryption for localStorage data using the Web Crypto API.
 * This provides defense-in-depth against casual snooping of localStorage.
 * For truly sensitive data, use server-side sessions instead.
 */

const STORAGE_KEY_NAME = 'beacon-storage-key'

async function getOrCreateKey(): Promise<CryptoKey> {
  // In a real production app, you'd derive this from the user's session.
  // For localStorage defense-in-depth, we use a session-scoped key.
  const existingKeyData = sessionStorage.getItem(STORAGE_KEY_NAME)

  if (existingKeyData) {
    const keyData = JSON.parse(existingKeyData)
    return crypto.subtle.importKey(
      'jwk',
      keyData,
      { name: 'AES-GCM', length: 256 },
      true,
      ['encrypt', 'decrypt']
    )
  }

  const key = await crypto.subtle.generateKey(
    { name: 'AES-GCM', length: 256 },
    true,
    ['encrypt', 'decrypt']
  )

  const exported = await crypto.subtle.exportKey('jwk', key)
  sessionStorage.setItem(STORAGE_KEY_NAME, JSON.stringify(exported))

  return key
}

export async function encryptData(data: string): Promise<string> {
  try {
    const key = await getOrCreateKey()
    const iv = crypto.getRandomValues(new Uint8Array(12))
    const encoded = new TextEncoder().encode(data)

    const encrypted = await crypto.subtle.encrypt(
      { name: 'AES-GCM', iv },
      key,
      encoded
    )

    // Combine IV and encrypted data, encode as base64
    const combined = new Uint8Array(iv.length + new Uint8Array(encrypted).length)
    combined.set(iv)
    combined.set(new Uint8Array(encrypted), iv.length)

    return btoa(String.fromCharCode(...combined))
  } catch {
    // Fallback: return data as-is if encryption fails (e.g., SSR)
    return data
  }
}

export async function decryptData(encryptedData: string): Promise<string> {
  try {
    const key = await getOrCreateKey()
    const combined = Uint8Array.from(atob(encryptedData), (c) => c.charCodeAt(0))

    const iv = combined.slice(0, 12)
    const data = combined.slice(12)

    const decrypted = await crypto.subtle.decrypt(
      { name: 'AES-GCM', iv },
      key,
      data
    )

    return new TextDecoder().decode(decrypted)
  } catch {
    // If decryption fails (key lost, corrupted data), return empty
    return '{}'
  }
}
