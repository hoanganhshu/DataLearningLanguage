# Meliya Chinese course structure

## Authoritative hierarchy

```text
Course: Chinese for Vietnamese speakers
└── HSK level block (HSK 1, HSK 2, ... HSK 7-9)
    └── Category: one communication topic
        └── Unit: Vocabulary / Grammar / Reading / Listening / Speaking / Application
            └── Activity: one learnable node for that unit and topic
```

`A1` is not used in Meliya-authored data. The A1 values in the imported Praktika export remain reference metadata only; CEFR is language-independent, but Meliya chooses HSK 3.0 as its Chinese curriculum framework.

## HSK category rule

- A category belongs to exactly one HSK level block.
- Its new vocabulary is selected manually from that HSK level.
- Vocabulary from lower HSK levels may appear only as review/context and is not counted as new vocabulary.
- Meliya does not need to cover every word in an HSK syllabus.
- The number of categories is not globally fixed. It is decided per HSK level after the editor selects useful communication captions and their required vocabulary.
- Higher HSK levels normally receive more categories because their selected communication vocabulary and captions are broader.

## Category authoring workflow

1. Choose the HSK block.
2. Write the communication caption and outcome.
3. Rate caption complexity: `SIMPLE`, `STANDARD`, or `COMPLEX`.
4. Manually select new words from the same HSK block using the caption complexity policy.
5. Verify every word against the local HSK mapping and dictionary.
6. Create the six skill units and their activities for that category.
7. Keep the category in draft until vocabulary and activities are approved.

## Current HSK 1 work

| Category | Status |
| --- | --- |
| C01 — Làm quen và tự giới thiệu | Vocabulary draft created |
| C02 — Con người và sinh hoạt hằng ngày | Vocabulary draft created |
| C03 — Thời gian và kế hoạch | Next draft |
| C04 — Ăn uống và dịch vụ cơ bản | Pending after C03 |

The earlier `drafts/course_blueprint.json` is an exploratory topic list only. This document overrides it for hierarchy and level assignment; a new HSK-level category catalog will replace that exploratory list before any curriculum import.
