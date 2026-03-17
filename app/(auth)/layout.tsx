export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="min-h-screen flex items-center justify-center gradient-primary relative overflow-hidden">
      {/* Subtle background glow */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute top-1/3 left-1/3 w-80 h-80 bg-[#c8612a] rounded-full opacity-5 blur-3xl" />
        <div className="absolute bottom-1/3 right-1/3 w-80 h-80 bg-[#a84e20] rounded-full opacity-5 blur-3xl" />
      </div>

      <div className="w-full max-w-md p-8 relative z-10">
        {children}
      </div>
    </div>
  )
}
