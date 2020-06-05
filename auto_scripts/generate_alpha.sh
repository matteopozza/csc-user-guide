echo "<h1> Applications in alphabetical order</h1>" > tmp_alpha && \
grep \* docs/apps/index.md | sort | uniq >> tmp_alpha && \
mv tmp_alpha docs/apps/alpha.md && exit 0;
