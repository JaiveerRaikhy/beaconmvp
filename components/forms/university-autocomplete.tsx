'use client'

import { useState, useEffect, useRef } from 'react'
import { Input } from '@/components/ui/input'
import { GraduationCap } from 'lucide-react'

interface University {
  id: string
  name: string
  location: string
}

interface UniversityAutocompleteProps {
  value: string
  onChange: (name: string, universityId: string | null) => void
  placeholder?: string
  id?: string
}

export function UniversityAutocomplete({
  value,
  onChange,
  placeholder = 'Search for your university...',
  id,
}: UniversityAutocompleteProps) {
  const [query, setQuery] = useState(value)
  const [suggestions, setSuggestions] = useState<University[]>([])
  const [loading, setLoading] = useState(false)
  const [showDropdown, setShowDropdown] = useState(false)
  const [isManualEntry, setIsManualEntry] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    setQuery(value)
  }, [value])

  useEffect(() => {
    if (query.length < 2) {
      setSuggestions([])
      return
    }

    // Don't search if the query exactly matches the current value (user selected from dropdown)
    if (query === value && value.length > 0) {
      return
    }

    const controller = new AbortController()

    const search = async () => {
      setLoading(true)
      try {
        const res = await fetch(
          `/api/universities/search?q=${encodeURIComponent(query)}`,
          { signal: controller.signal }
        )
        if (res.ok) {
          const data: University[] = await res.json()
          setSuggestions(data)
          setShowDropdown(true)
        }
      } catch (err) {
        if (err instanceof DOMException && err.name === 'AbortError') return
      } finally {
        setLoading(false)
      }
    }

    const debounce = setTimeout(search, 250)
    return () => {
      clearTimeout(debounce)
      controller.abort()
    }
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

  const selectUniversity = (uni: University) => {
    setQuery(uni.name)
    setIsManualEntry(false)
    onChange(uni.name, uni.id)
    setSuggestions([])
    setShowDropdown(false)
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value
    setQuery(val)
    setIsManualEntry(true)
    // Free-text input: pass null university_id
    onChange(val, null)
  }

  return (
    <div className="relative" ref={dropdownRef}>
      <GraduationCap className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
      <Input
        id={id}
        placeholder={placeholder}
        value={query}
        onChange={handleInputChange}
        onFocus={() => suggestions.length > 0 && setShowDropdown(true)}
        className="pl-10"
        autoComplete="off"
      />

      {showDropdown && (suggestions.length > 0 || loading) && (
        <div className="absolute top-full left-0 right-0 mt-1 bg-card border rounded-md shadow-lg z-10 max-h-56 overflow-auto">
          {suggestions.map((uni) => (
            <div
              key={uni.id}
              className="px-4 py-2.5 hover:bg-accent/50 cursor-pointer"
              onClick={() => selectUniversity(uni)}
            >
              <p className="text-sm font-medium">{uni.name}</p>
              <p className="text-xs text-muted-foreground">{uni.location}</p>
            </div>
          ))}
          {loading && (
            <div className="px-4 py-2 text-sm text-muted-foreground">Searching...</div>
          )}
          {!loading && suggestions.length === 0 && query.length >= 2 && (
            <div className="px-4 py-2 text-sm text-muted-foreground">
              No matches — you can type a custom school name
            </div>
          )}
        </div>
      )}

      {isManualEntry && query.length >= 2 && !showDropdown && (
        <p className="text-xs text-muted-foreground mt-1">
          Using custom school name. Select from the dropdown to link to a known university.
        </p>
      )}
    </div>
  )
}
