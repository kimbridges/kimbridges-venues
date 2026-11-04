# MRC chapter 2 -- Learning the scale: notes
_Started 2026-11-03._

**Worked example (AI elicitation), built 2026-11-03:** R/ch02_llm_elicit.R, R/ch02_fig1_llm_scales.R, data/llm_comfort_thresholds_24cities.csv,
figures/ch02_fig1_llm_scales. 24 cities (Fairbanks to Singapore) x 3 models (Claude Sonnet 5.5, GPT-5-mini, Gemini 3.8 Flash) x 3 repeats = 216
answers; question: where do long-time residents start to call it 'cold', 'chilly', 'warm', 'hot' (deg F). Climate: WorldClim 2.1 via whittakerr cache.

**Findings (all three models agree):**
- 'cold' moves with climate almost one for one: ~10 F per 10 F of annual mean (models 9.2 / 10.5 / 11.1); 'hot' only ~3 F per 10 F (2.7-3.1).
- So the vocabulary STRETCHES AND SQUEEZES to the local seasons: span from 'cold' to 'hot' ~19 F in Singapore, ~24 F in Honolulu, >70 F in
  Fairbanks and Ulaanbaatar. Span of words vs seasonal range (warmest minus coldest quarter): r = 0.96 overall (models 0.92-0.97), slope ~0.83.
- Reading: roughly the same handful of categories laid over whatever range a place has (Miller); 'thin blood' at the scale of a vocabulary.
- ASHRAE 55 adaptive comfort (0.31 x outdoor mean + 17.8 C; 10-33.5 C; +/-3.5 C at 80%) sits near the 'warm' threshold -- but it is INDOOR
  comfort in naturally ventilated buildings and uses a running mean, not annual: a different operation (Bridgman), shown only for comparison.

**Caveats for the text:** the models report what their training says people say -- a HYPOTHESIS about human usage, not a measurement of
humans; the three models are not independent (shared sources). Next check (open): a human-data source on regional temperature words
(surveys or social-media studies) to test the stretch-to-fit finding. Run notes: a single sequential run stalled (>26 min) -- rerun as three
parallel per-model jobs with per-city checkpoints; GPT-5-mini ~70 s per city, Gemini ~35 s, Claude ~6 s.
