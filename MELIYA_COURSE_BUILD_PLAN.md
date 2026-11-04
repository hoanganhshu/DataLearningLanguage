# Meliya Chinese course build plan

This repository contains the approved HSK vocabulary source. It is not the production course itself.

The authoritative authored-course hierarchy is documented in `meliya/zh-vi/MELIYA_HSK_COURSE_STRUCTURE.md`.

## Status

- HSK vocabulary source: approved and imported into Meliya local PostgreSQL as level metadata.
- Course content: not imported.
- Current task: create reviewable drafts before any curriculum/content import.

## Build order

1. Review `meliya/zh-vi/drafts/course_blueprint.json`.
   - It defines 8 communication categories.
   - Each category uses the Praktika-like 6-unit rhythm: Vocabulary, Grammar, Reading, Listening, Speaking, Application.
   - It contains only original Meliya titles/objectives and HSK target bands.
2. Generate candidate vocabulary lists for Category 1 from the HSK mapping.
   - Filter by HSK target band and frequency.
   - Select only words relevant to the category objective.
   - Keep candidates in a review file; do not import them into a course yet.
3. After vocabulary approval, create 21 activity metadata records for Category 1.
4. Write original Meliya activity/material JSON for Category 1.
   - Do not reuse lesson text, audio, images, exercises or scripts from other applications.
5. Validate activity JSON and run it on Android against the local backend.
6. Import only approved Meliya-authored curriculum data into PostgreSQL.
7. Repeat category by category.

## Content rules

- HSK is used as a difficulty and coverage constraint, not as a pre-made course.
- New vocabulary is selected manually by the editor from both target HSK band and the difficulty of the activity caption/communication outcome; it is not a fixed 5-word template.
- A lower-level word reused for review does not count as a new-word quota.
- A sentence/activity should use the target HSK band or lower, aside from words introduced by that activity.
- Grammar notes, Vietnamese explanations, scenarios, avatar prompts and TTS text are authored by Meliya.
- HSK source and any third-party data retain their attribution/license obligations.
