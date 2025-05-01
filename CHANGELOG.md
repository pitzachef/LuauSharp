# Luau# Changelog

## [1.0.0] - Initial Release
### Features
- Complete C# to Luau compilation system
- Bidirectional conversion between C#-style and Luau
- External dictionary loading system
- Core C# syntax support:
  - Variable declarations
  - Class definitions
  - Method definitions
  - Control flow statements
  - Operators
- Import system for module requirements
- Error handling in compilation
- Support for:
  - Classes
  - Methods
  - Properties
  - Basic LINQ operations
  - Events
  - Type checking

## [1.1.0] - Dictionary Update
### Changes
- Separated _dluau and _dcluau into external files
- Added retry mechanism for dictionary loading
- Improved operator conversions
- Added support for:
  - Try/catch/finally blocks
  - Property accessors
  - Lambda expressions
  - Generic type patterns

## [1.1.1] - Syntax Parsing Fix
### Fixed
- Removed problematic `::` parsing 
- Corrected service getter syntax
- Added proper method call conversion (`.` to `:`)
- Fixed scoping operator translations

## [1.2.2] - Rewrite
### Changes
- Removed catch and fetch
+ Faster compiler
