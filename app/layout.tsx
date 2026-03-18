import type { Metadata } from "next";
import { Inter, Geist_Mono, Playfair_Display } from "next/font/google";
import { Toaster } from "@/components/ui/sonner";
import "./globals.css";

const inter = Inter({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const playfair = Playfair_Display({
  variable: "--font-playfair",
  subsets: ["latin"],
  weight: ["400", "700"],
  style: ["normal", "italic"],
});

export const metadata: Metadata = {
  title: {
    default: "Beacon - Find Your Career Mentor",
    template: "%s | Beacon",
  },
  description: "Beacon connects aspiring professionals with experienced mentors who've walked the path before. Get matched, get guidance, get ahead.",
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'https://beacon.app'),
  openGraph: {
    title: "Beacon - Find Your Career Mentor",
    description: "Connect with experienced mentors who've walked the path before.",
    siteName: "Beacon",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Beacon - Find Your Career Mentor",
    description: "Connect with experienced mentors who've walked the path before.",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${inter.variable} ${geistMono.variable} ${playfair.variable} antialiased`}
      >
        {children}
        <Toaster />
      </body>
    </html>
  );
}
