# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Test Commands

```bash
# Run all tests
rake test
# or
make test

# Run a single test file
ruby -Ilib:test test/smartystreets_ruby_sdk/test_batch.rb

# Install dependencies
gem install minitest

# Build the gem (used by CI, requires VERSION env var)
make package

# Run all example scripts (requires SMARTY_AUTH_ID and SMARTY_AUTH_TOKEN env vars)
make examples
```

## Architecture

This is the official SmartyStreets Ruby SDK for address verification APIs. It uses pure Ruby with Net::HTTP (no external runtime dependencies).

### Core Design Patterns

**Builder Pattern**: `ClientBuilder` provides a fluent interface for configuring API clients:
```ruby
credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)
client = SmartyStreets::ClientBuilder.new(credentials)
    .retry_at_most(5)
    .with_licenses(['us-rooftop-geocoding-cloud'])
    .build_us_street_api_client
```

**Chain of Responsibility**: HTTP requests flow through a middleware chain of "Sender" objects. Each sender wraps an inner sender:
```
URLPrefixSender → LicenseSender → RetrySender → SigningSender → StatusCodeSender → NativeSender
```

### Key Components

- **lib/smartystreets_ruby_sdk.rb**: Main entry point, requires all modules
- **client_builder.rb**: Constructs sender chains and API clients
- **Sender classes**: Middleware for URL prefixing, retries, authentication, status code handling
- **API modules** (us_street/, us_zipcode/, international_street/, etc.): Each contains:
  - `client.rb`: API client with `send_lookup()` and `send_batch()` methods
  - `lookup.rb`: Input model (JSONAble mixin for serialization)
  - Response classes (candidate.rb, result.rb, etc.)

### Supported APIs

- US Street, US ZipCode, US Autocomplete Pro, US Extract, US Reverse Geo, US Enrichment
- International Street, International Autocomplete, International Postal Code

### Test Structure

Tests use Minitest with mock objects in `test/mocks/`. Test files mirror the lib structure under `test/smartystreets_ruby_sdk/`.

### Adding New API Support

1. Create new directory under `lib/smartystreets_ruby_sdk/` with client, lookup, and response classes
2. Add `build_[api]_client` method to `client_builder.rb`
3. Add requires to main `smartystreets_ruby_sdk.rb`
4. Create corresponding test files and example script
