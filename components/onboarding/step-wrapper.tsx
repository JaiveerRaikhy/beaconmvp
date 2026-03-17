interface StepWrapperProps {
  title: string
  subtitle?: string
  children: React.ReactNode
}

export function StepWrapper({ title, subtitle, children }: StepWrapperProps) {
  return (
    <div className="space-y-6">
      <div className="text-center">
        <h1 className="text-2xl font-bold">{title}</h1>
        {subtitle && (
          <p className="text-muted-foreground mt-1">{subtitle}</p>
        )}
      </div>
      <div className="bg-card rounded-xl border border-orange-200/30 p-6">
        {children}
      </div>
    </div>
  )
}
