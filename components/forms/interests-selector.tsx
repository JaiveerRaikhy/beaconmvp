'use client'

import { useState, useEffect, useRef } from 'react'
import { createClient } from '@/lib/supabase/client'
import { sanitizeSearchQuery, sanitizeText } from '@/lib/security/sanitize'
import { Input } from '@/components/ui/input'
import { X, Search } from 'lucide-react'

interface InterestsSelectorProps {
  selected: string[]
  onChange: (interests: string[]) => void
  max?: number
}

export function InterestsSelector({
  selected,
  onChange,
  max = 15
}: InterestsSelectorProps) {
  const [query, setQuery] = useState('')
  const [suggestions, setSuggestions] = useState<Array<{ id: string, name: string }>>([])
  const [loading, setLoading] = useState(false)
  const [showDropdown, setShowDropdown] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)
  const supabase = createClient()

  useEffect(() => {
    if (query.length < 2) {
      setSuggestions([])
      return
    }

    const search = async () => {
      setLoading(true)
      const sanitizedQuery = sanitizeSearchQuery(query)
      if (!sanitizedQuery) {
        setSuggestions([])
        setLoading(false)
        return
      }
      const { data } = await supabase
        .from('interests')
        .select('id, name')
        .ilike('name', `%${sanitizedQuery}%`)
        .limit(10)

      setSuggestions(data || [])
      setLoading(false)
      setShowDropdown(true)
    }

    const debounce = setTimeout(search, 300)
    return () => clearTimeout(debounce)
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [query])

  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setShowDropdown(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  const addInterest = (interest: string) => {
    if (selected.length >= max) return
    if (!selected.includes(interest)) {
      onChange([...selected, interest])
    }
    setQuery('')
    setSuggestions([])
    setShowDropdown(false)
  }

  const removeInterest = (interest: string) => {
    onChange(selected.filter(i => i !== interest))
  }

  // Allow typing custom interests on Enter
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter' && query.trim().length >= 2) {
      e.preventDefault()
      // If suggestions exist, add the first one; otherwise add the custom text
      if (suggestions.length > 0) {
        addInterest(suggestions[0].name)
      } else {
        const sanitized = sanitizeText(query.trim())
        if (sanitized.length >= 2) {
          addInterest(sanitized)
        }
      }
    }
  }

  return (
    <div className="space-y-4">
      <div className="relative" ref={dropdownRef}>
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
        <Input
          placeholder="Search interests..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onFocus={() => suggestions.length > 0 && setShowDropdown(true)}
          onKeyDown={handleKeyDown}
          className="pl-10"
          disabled={selected.length >= max}
        />

        {showDropdown && suggestions.length > 0 && (
          <div className="absolute top-full left-0 right-0 mt-1 bg-card border rounded-md shadow-lg z-10 max-h-48 overflow-auto">
            {suggestions
              .filter(s => !selected.includes(s.name))
              .map((interest) => (
                <div
                  key={interest.id}
                  className="px-4 py-2 hover:bg-accent/50 cursor-pointer text-sm"
                  onClick={() => addInterest(interest.name)}
                >
                  {interest.name}
                </div>
              ))}
            {loading && (
              <div className="px-4 py-2 text-sm text-muted-foreground">Searching...</div>
            )}
          </div>
        )}
      </div>

      {selected.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {selected.map((interest) => (
            <span
              key={interest}
              className="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 text-sm"
            >
              {interest}
              <X
                className="w-3 h-3 cursor-pointer hover:text-emerald-500"
                onClick={() => removeInterest(interest)}
              />
            </span>
          ))}
        </div>
      )}

      <p className="text-sm text-muted-foreground">
        {selected.length}/{max} interests selected
        {selected.length < 5 && ' (try to add at least 5)'}
      </p>
    </div>
  )
}
