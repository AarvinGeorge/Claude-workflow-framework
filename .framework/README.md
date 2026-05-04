# `.framework/` — Docs and Tooling

This directory contains the framework's documentation, scripts, and
bundle library. It persists alongside your project so all framework
material stays accessible after you replace the top-level README.

For the framework's full explanation, see the
[root README](../README.md).

---

## Index

| File / dir | Purpose |
|---|---|
| [`METHODOLOGY.md`](METHODOLOGY.md) | The 6 D's methodology — phases, activities, outputs, done-when criteria |
| [`CAPABILITY_MAP.md`](CAPABILITY_MAP.md) | Skill-to-phase mapping. Living doc; update when toolkit changes |
| [`WORKFLOW.md`](WORKFLOW.md) | Visual workflow — lifecycle diagram, dialogue snapshot, swim lanes, CLAUDE.md evolution. Update when user-visible workflow changes |
| [`EVOLUTION.md`](EVOLUTION.md) | 4-question loop for adding new skills/plugins/MCPs |
| [`INIT.md`](INIT.md) | Starter checklist for new projects (most of this is automated; INIT.md is the backup reference) |
| [`CHANGELOG.md`](CHANGELOG.md) | Framework version history |
| [`LICENSE`](LICENSE) | MIT |
| [`scripts/check-setup.sh`](scripts/check-setup.sh) | Verifies tools + plugins on first session |
| [`scripts/install-bundle.sh`](scripts/install-bundle.sh) | One-command bundle install (cp + jq merge + CLAUDE.md append) |
| [`bundles/`](bundles/) | Domain add-ons. See [`bundles/BUNDLE_GUIDE.md`](bundles/BUNDLE_GUIDE.md) |

---

## When to read what

- **Starting a new project** → root README + [`INIT.md`](INIT.md)
- **Want to picture how a project unfolds end-to-end** →
  [`WORKFLOW.md`](WORKFLOW.md) (lifecycle diagram, dialogue snapshot,
  swim lanes)
- **Mid-project, unsure what to do next** → [`METHODOLOGY.md`](METHODOLOGY.md)
  for phase guidance + [`CAPABILITY_MAP.md`](CAPABILITY_MAP.md) for
  skill choices
- **Found a useful new skill** → [`EVOLUTION.md`](EVOLUTION.md)
- **Authoring a bundle** → [`bundles/BUNDLE_GUIDE.md`](bundles/BUNDLE_GUIDE.md)
- **Tracing what changed in the framework** → [`CHANGELOG.md`](CHANGELOG.md)
