# Kattakath Technologies Inc. Website - Claude Code Documentation

## Project Overview

This is the official website for **Kattakath Technologies Inc.**, hosted at `kattakath.com`. The website serves as the primary online presence for the company, showcasing services, technologies, and company information.

## Technology Stack

### Core Framework
- **Astro 5.x** - Modern web framework chosen for:
  - Superior performance with minimal JavaScript by default
  - Excellent SEO capabilities
  - Static site generation
  - Component-based architecture
  - Support for multiple UI frameworks if needed

### Development Tools
- **TypeScript** (Strict mode) - Type-safe development
- **Node.js 18+** - Runtime environment
- **npm** - Package manager

## Project Structure

```
kattakath-com/
├── src/
│   ├── pages/              # Route-based pages (.astro files)
│   │   └── index.astro     # Homepage
│   ├── layouts/            # Layout components (to be added)
│   ├── components/         # Reusable components (to be added)
│   └── styles/             # Global styles (to be added)
├── public/                 # Static assets served as-is
│   └── favicon.svg         # Site favicon
├── astro.config.mjs        # Astro configuration
├── tsconfig.json           # TypeScript configuration
├── package.json            # Dependencies and scripts
├── .gitignore              # Git ignore rules
├── README.md               # User-facing documentation
└── CLAUDE.md               # This file - AI assistant context
```

## Development Workflow

### GitHub Flow
This project strictly follows **GitHub Flow** for code maintenance:

1. **Main branch** (`main`) is always deployable
2. Create **feature branches** from `main` for new work
3. Branch naming convention: `feature/description`, `fix/description`, `docs/description`
4. Make commits with clear, descriptive messages
5. Open **Pull Requests** for review
6. Require approvals before merging
7. Delete feature branches after merging

### Branch Protection Rules
The `main` branch has the following protections:
- Require pull request reviews before merging
- Require status checks to pass
- No direct pushes to `main`
- No force pushes
- No deletions

## Available Scripts

```bash
npm run dev      # Start development server at http://localhost:4321
npm run build    # Build for production (includes type checking)
npm run preview  # Preview production build locally
npm run astro    # Run Astro CLI commands
```

## Astro Framework Documentation Access

This project has access to comprehensive Astro documentation via **Context7 MCP**. When working on Astro-related features:

1. Use Context7 library ID: `/websites/astro_build_en` (17,075 code snippets, Trust Score: 10)
2. Alternative comprehensive resource: `/llmstxt/astro_build_llms-full_txt` (18,023 snippets)
3. Official Astro docs: `/withastro/docs` (2,735 snippets)

Key Astro concepts to remember:
- **Component Islands** - Interactive UI components load only when needed
- **Zero JavaScript by default** - JS only added when explicitly needed
- **File-based routing** - Pages in `src/pages/` become routes
- **.astro components** - Mix of HTML, CSS, and JS in single files

## Code Style and Best Practices

### TypeScript
- Strict mode enabled
- Use proper types, avoid `any`
- Leverage Astro's built-in type checking

### Component Development
- Prefer `.astro` components for content-focused pages
- Use framework components (React, Vue, etc.) only when interactivity is needed
- Keep components small and focused
- Extract reusable logic into separate files

### Performance
- Minimize client-side JavaScript
- Optimize images (use Astro's image optimization)
- Lazy load when appropriate
- Follow Astro's best practices for performance

### Accessibility
- Use semantic HTML
- Include proper ARIA labels when needed
- Ensure keyboard navigation works
- Test with screen readers

## Git Commit Guidelines

Follow conventional commit format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Example:
```
feat(homepage): add hero section with company overview

- Add hero component with gradient background
- Include call-to-action buttons
- Implement responsive design for mobile

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

## Deployment

### Hosting
- Domain: `kattakath.com`
- Deployment platform: TBD (consider Netlify, Vercel, or Cloudflare Pages)

### Build Output
- Static site generated in `dist/` directory
- Can be deployed to any static hosting service
- No server-side runtime required

## Environment Variables

Create `.env` file for environment-specific configuration:

```bash
# Example:
# PUBLIC_API_URL=https://api.example.com
# PRIVATE_API_KEY=your-key-here
```

Note: Prefix public variables with `PUBLIC_` to expose them to the browser.

## MCP Tools Available

This project has access to the following MCP servers:

### Context7
- Get library documentation for various frameworks
- Access to comprehensive Astro documentation

### GitHub Official
- Repository management
- Issue and PR operations
- Branch and commit operations

### Git
- Local git operations
- Status, diff, log, etc.

### Desktop Commander
- File system operations
- Process management
- Advanced file operations

Use these tools when appropriate to streamline development.

## Future Enhancements

Potential areas for expansion:
- Blog/News section
- Services/Products pages
- Team/About pages
- Contact forms
- Integration with CMS (e.g., Strapi, Sanity)
- Internationalization (i18n)
- Analytics integration
- SEO optimizations

## Support and Contact

For questions or issues related to this codebase:
- Create an issue in the GitHub repository
- Follow the pull request process for contributions
- Ensure all code follows the established patterns and guidelines

## References

- [Astro Documentation](https://docs.astro.build/)
- [Astro GitHub Repository](https://github.com/withastro/astro)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)

---

**Last Updated**: 2026-01-17
**Project Status**: Initial Setup
**Astro Version**: 5.1.3
