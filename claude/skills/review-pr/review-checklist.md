# Review checklist

**Blocking** marks what makes a finding 🔴 on its own.

## What to look for

1. **Prove it works.** The evidence fits the change. A ticked checkbox isn't evidence.
   - CI or workflow change: a run from the branch.
   - Retries, waits or longer timeouts for flakiness: the failing runs.
   - Performance or size claim: a measurement.
   - Deploy-path change: a run, or why the path is unchanged.
   - Visual change: before and after.
   - Code the tests never run (wiring, real credentials, the real network): a manual run.

   **Blocking:** a risky change with no evidence that it ran.
2. **Fix the cause, not the symptom.** New lint suppressions, casts, unwraps or non-null assertions; swallowed errors; retries or timeouts with no root cause; a test changed to match a fake instead of fixing the fake; a parallel API added beside one that "doesn't work". Check whether the proper fix is reachable and propose it.

   **Blocking:** a guard weakened to get CI green: a lint rule, an assertion, a gate or a quarantined test.
3. **Fail loudly.** A missing required config value, env var or file is an error, not a quiet skip (watch for empty strings). No fallbacks that hide missing data. A test that can't fail is a bug: constant assertions, assertions before async work settles, loops over a collection that may be empty, a name that doesn't match the assertions. The exception is a performance shortcut such as a cache, which must fail to the slow, correct path, never to a stale result.
4. **Test behaviour.** Tests go through the public surface, against real dependencies or stand-ins checked against the real service's source or docs, not mocks of the code under test. No fixed sleeps. Each way a command or handler can end has a test, including refusals before the network.
5. **Stay in scope.** Every hunk matches the stated purpose. Lockfile churn is explained by a manifest change. No stale-branch commits, search-and-replace overreach or leftover toggles. Bot and dependency PRs change only manifests and lockfiles. Name another team's area when the PR touches it. For AI-authored PRs, flag fixes outside the task.

   **Blocking:** destructive accidental diffs: deleted ownership entries, conflict markers, reverted lockfile entries.
6. **Leave nothing behind.** Debug leftovers, commented-out code, scratch files. AI artifacts: plan docs, summaries, one-off scripts, READMEs that restate the code, tests that assert nothing. Comments that narrate history or will go stale. Incomplete deletions: grep for the removed thing's helpers, fields, tests, docs and config. These are nits, except debug code that reaches production.
7. **Reuse and respect boundaries.** Search for an existing helper, fixture, shared package or built-in before accepting new logic, and flag only what you found, with its path. Placement follows the repo's layout rules. A new dependency needs a reason, sits in the right section (dev or runtime) and duplicates no package the repo already has. Follow the build tool's conventions rather than working around them.

   **Blocking:** module-boundary violations, and test-only code that release builds can reach.
8. **Protect data and secrets.** No secrets in code, config, workflow inputs, logs or errors. New secret-scanner ignores are suspicious. Third-party CI actions are pinned by SHA. A credential sent to a configurable URL needs that URL checked (https, or http on loopback) and redirects not followed blindly. Scopes and permissions are the least that works.

   **Blocking:** possible PII or credential exposure, and committed secrets.
9. **Explain the why.** A risky change's description says why, not just what. A workaround (cast, suppression, patch, pinned version, TODO) carries a comment with its reason and exit condition. Names say what a thing is. An invariant the next PR must respect belongs in a code comment, not only the PR body.
10. **Rate the merge risk** of CI, deploy, build-graph and cache changes.
    - CI: a required job renamed, removed or made skippable; a stricter check that doesn't fix or allowlist existing violations.
    - Deploy path: a gating change must not deploy after a failure or silently stop deploys.
    - Behaviour change: if shipped behaviour or existing tests can change, the description says so and how it was checked.
    - Caches: a new or wider cache states its key, what invalidates it, who writes it, how stale a hit can be and what a miss does.
    - Build graph: tasks declare complete inputs and outputs. No implicit dependencies covering a missing import, no loosened boundaries.

    **Blocking:** a cache that can return a result computed from different inputs.
11. **Patched dependencies.** Bumping a package with a local patch (`patches/`, `patchedDependencies`, patch-package) needs three answers: the patch still applies to the new release, its behaviour still happens on the new version, and it's still needed (find the PR that added it with `git log --follow`, and check whether upstream now covers it).

    **Blocking:** a re-keyed patch with no evidence that its behaviour still works.

## Don't flag

- Style, or anything a linter or formatter enforces.
- Preference-only rewrites, micro-optimizations, memoizing cheap pure code, placement within a module.
- Documented exceptions, and patterns the repo already uses.
- Pre-existing debt the PR only touches.
- Small drive-by fixes the description calls out.
- Anything already raised in the PR.
- Anything the code contradicts.
