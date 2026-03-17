'use client'

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <html lang="en" className="dark">
      <body className="min-h-screen bg-[#0F172A] text-[#F8FAFC] flex items-center justify-center font-sans antialiased">
        <div className="text-center space-y-6 px-4 max-w-md">
          <div className="w-16 h-16 mx-auto rounded-full bg-[rgba(239,68,68,0.1)] flex items-center justify-center">
            <svg className="w-8 h-8 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.082 16.5c-.77.833.192 2.5 1.732 2.5z" />
            </svg>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Something went wrong</h1>
            <p className="text-[#64748B] mt-2">
              An unexpected error occurred. Please try again.
            </p>
          </div>
          <button
            onClick={reset}
            className="inline-flex items-center justify-center rounded-md bg-[#c8612a] px-6 py-2.5 text-sm font-medium text-white hover:bg-[#a84e20] transition-colors focus:outline-none focus:ring-2 focus:ring-[#c8612a] focus:ring-offset-2 focus:ring-offset-[#f7f0e6]"
          >
            Try again
          </button>
        </div>
      </body>
    </html>
  )
}
