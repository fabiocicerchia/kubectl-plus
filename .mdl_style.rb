all

# Markdown tables and fenced code can't be wrapped without breaking rendering.
rule 'MD013', line_length: 100, tables: false, ignore_code_blocks: true

# Accept sequentially numbered ordered lists (1. 2. 3.), not just "1." repeated.
rule 'MD029', style: :ordered

# GitHub issue/PR templates intentionally lead with front matter or an H2,
# not a top-level H1 — these two rules conflict with that convention.
exclude_rule 'MD002'
exclude_rule 'MD041'
