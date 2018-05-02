# There are a few guidelines to follow when contributing to this project.

1. Always use a Pull Request to submit a change
2. If its a non-trivial change or new feature, always discuss it with the core contributor(s) first via the issues – PRs that don't follow this rule will likely be declined
3. No new dependencies will be accepted
4. Extensions support
5. Always use SwiftLint to ensure coding styles are met

## Pull Requests

Pull requests should also point to `develop`. No requests made to `master` will be allowed.

All changes, no matter how trivial, must be done via pull request. Commits should never be made directly on the master branch.

## Feature Requests

If you have a feature request, please open an Issue about it first. I will reply to all feature requests but its important that it fits within the design goals and feature roadmap of the product.

So open an issue and we can discuss it, I'm always open to new ideas and suggestions, I just prefer to discuss first.

## Dependencies

One of Peek's design goals is to keep things simple and to have extremely minimal impact on the running app. To that end, I have slowly implemented light-weight versions of libraries that were previously included and managed to strip out all other dependencies.

> Thus, no new dependencies will be introduced into Peek in the future.

## Extensions

However there are times where a 3rd party component adds value to the project. To satisfy this requirement I am currently working on an Extension based architecture that will make this easier to build where the dependency is inverted. Those projects can depend on Peek instead and still benefit from the best of both worlds

## SwiftLint

The project has already been configured to use SwiftLint, so ensure you have this installed and all issues fixed before submitting a PR

## README

Where applicable, you should ensure the README is also maintained. A typical example is where a new feature is introduced that warrants some explanation, or perhaps an update to the changelog.
