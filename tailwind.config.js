/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-geist)', 'system-ui', 'sans-serif'],
        mono: ['var(--font-geist-mono)', 'monospace'],
        display: ['var(--font-display)', 'system-ui', 'sans-serif'],
      },
      colors: {
        orbit: {
          50:  '#f0f4ff',
          100: '#e0e9ff',
          200: '#c7d7fe',
          300: '#a5b9fc',
          400: '#8191f8',
          500: '#6366f1',
          600: '#4f46e5',
          700: '#4338ca',
          800: '#3730a3',
          900: '#312e81',
          950: '#1e1b4b',
        },
        neon: {
          cyan:    '#00fff5',
          purple:  '#bf00ff',
          pink:    '#ff006e',
          green:   '#00ff9f',
          orange:  '#ff6a00',
          blue:    '#0066ff',
        },
        glass: {
          DEFAULT: 'rgba(255,255,255,0.05)',
          hover:   'rgba(255,255,255,0.08)',
          border:  'rgba(255,255,255,0.1)',
        },
      },
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'grid-pattern': `linear-gradient(rgba(99,102,241,0.05) 1px, transparent 1px),
                         linear-gradient(90deg, rgba(99,102,241,0.05) 1px, transparent 1px)`,
      },
      animation: {
        'fade-in':      'fadeIn 0.5s ease-out',
        'slide-up':     'slideUp 0.5s ease-out',
        'slide-in':     'slideIn 0.3s ease-out',
        'pulse-slow':   'pulse 4s cubic-bezier(0.4,0,0.6,1) infinite',
        'float':        'float 6s ease-in-out infinite',
        'glow':         'glow 2s ease-in-out infinite alternate',
        'shimmer':      'shimmer 2s linear infinite',
      },
      keyframes: {
        fadeIn:  { from: { opacity: '0' },            to: { opacity: '1' } },
        slideUp: { from: { opacity: '0', transform: 'translateY(20px)' }, to: { opacity: '1', transform: 'translateY(0)' } },
        slideIn: { from: { opacity: '0', transform: 'translateX(-20px)' }, to: { opacity: '1', transform: 'translateX(0)' } },
        float:   { '0%,100%': { transform: 'translateY(0px)' }, '50%': { transform: 'translateY(-10px)' } },
        glow:    { from: { boxShadow: '0 0 5px #6366f1, 0 0 10px #6366f1' }, to: { boxShadow: '0 0 20px #6366f1, 0 0 40px #6366f1' } },
        shimmer: { '0%': { backgroundPosition: '-200% 0' }, '100%': { backgroundPosition: '200% 0' } },
      },
      backdropBlur: { xs: '2px' },
      boxShadow: {
        'glass':     '0 8px 32px 0 rgba(0,0,0,0.37)',
        'neon':      '0 0 20px rgba(99,102,241,0.5)',
        'neon-lg':   '0 0 40px rgba(99,102,241,0.6)',
        'card':      '0 4px 24px rgba(0,0,0,0.4)',
        'card-hover':'0 8px 40px rgba(0,0,0,0.6)',
      },
    },
  },
  plugins: [],
};
