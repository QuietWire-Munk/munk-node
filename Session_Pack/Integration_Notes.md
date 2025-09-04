# Integration Notes — Combined System Repo (Lunch Sprint)

## Goal
Assemble a minimal **Combined System** that shows how five nodes interoperate via small, reliable interfaces.

## Steps
1. **Collect** team repo URLs and clone locally.
2. **Normalize**: ensure each has `README.md`, `Protocols/`, `Narratives/`, `Governance/`.
3. **Define Interfaces** (YAML/MD):
   - `/interfaces/alerts.md`: who publishes what fields (title, severity, TTL, contact).
   - `/interfaces/events.md`: event metadata and safety posture.
   - `/interfaces/briefs.md`: policy/insight brief schema (owner, audience, version).
4. **Bridge Scripts (optional)**: simple copy/merge or a `Makefile` that pulls latest artifacts from each team into `combined/`.
5. **Document Conflicts**: list where isolation caused friction (terminology, ownership, data fields).
6. **Demo**: show alerts flowing; show how a narrative shock is handled across nodes.

## Deliverables
- Combined System repo README
- `interfaces/` directory with schemas
- `combined/` directory with a snapshot of each team’s current artifacts
